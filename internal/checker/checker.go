package checker

import (
	"context"
	"embed"
	"strings"

	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/internal/logger"
	"github.com/carbonetes/brainiac/internal/module"
	"github.com/carbonetes/brainiac/pkg/model"
	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
	"golang.org/x/exp/slices"
)

//go:embed */rules
var EmbededRules embed.FS

const (
	severityLow      = "LOW"
	severityMedium   = "MEDIUM"
	severityHigh     = "HIGH"
	severityCritical = "CRITICAL"
	failedCheck      = "FAILED"
	passedCheck      = "PASSED"

	baseModulePrefix = "data.lib."
)

var (
	log        = logger.GetLogger()
	Severities = []string{
		severityLow,
		severityMedium,
		severityHigh,
		severityCritical,
	}
)

// subject for modification once the research for rego is finish
func CheckIACFile(config, configFile string) (model.Result, error) {

	switch config {
	case file.FileTypeKubernetes:
		modules, err := module.ModuleParser(config, EmbededRules)
		if err != nil && modules == nil {
			log.Printf("Failed to parse rego modules")
			Errors = append(Errors, &err)
			return model.Result{}, err
		}
		input, rawContent := file.ParseKubernetesFile(configFile)
		return proccessInput(input, rawContent, modules, file.FileTypeKubernetes, configFile)
	case file.FileTypeTerraform:

		modules, err := module.ModuleParser(config, EmbededRules)
		if err != nil && modules == nil {
			log.Printf("Failed to parse rego modules")
			Errors = append(Errors, &err)
			return model.Result{}, err
		}
		input, rawContent := file.ParseTerraformFile(configFile)
		return proccessInput(input, rawContent, modules, file.FileTypeTerraform, configFile)

	case file.FileTypeDockerfile:

		//implement other config type here
	}
	return model.Result{}, nil

}

// Process input to query on list of modules
func proccessInput(input interface{}, rawContent string, modules map[string]*ast.Module, configType string, configFile string) (model.Result, error) {
	// init variable
	var IACResults = new(model.Result)
	IACResults.CheckType = configType
	baseModule := baseModulePrefix + configType

	ctx := context.Background()
	//compile rego modules
	compiler := compileModules(modules)
	for _, module := range modules {
		if moduleSkipByID(module) || moduleSkipBySeverity(module) {
			continue
		}
		packageName := module.Package.Path.String()
		if packageName == baseModule {
			continue
		}

		baseRego := rego.New(
			rego.Query(packageName),
			rego.Compiler(compiler),
			rego.Input(input),
		)
		result, err := baseRego.Eval(ctx)
		if err != nil {
			Errors = append(Errors, &err)
			continue
		}
		if len(result) > 0 {
			checks, _ := parseRegoResult(result, module, configFile, rawContent)
			if checks.Title != "" {
				updateResults(checks, IACResults)
			}
		}

	}
	return *IACResults, nil
}

func updateResults(check model.Check, IACResults *model.Result) {
	if check.CheckResult == failedCheck {
		//append to failed
		countSeverity(check.Severity, IACResults)
		IACResults.FailedChecks = append(IACResults.FailedChecks, check)
	} else {
		IACResults.PassedChecks = append(IACResults.PassedChecks, check)
	}

	finalizeResults(IACResults)

}

func moduleSkipByID(module *ast.Module) bool {

	// return if no annotations
	if len(module.Annotations) == 0 {
		return false
	}

	//check args check or skipp check if equal to moodule id
	checkId := module.Annotations[0].Custom["id"].(string)
	check := *Arguments.Check
	skipCheck := *Arguments.SkipCheck
	if len(check) > 0 {
		return !slices.Contains(check, checkId)
	} else if len(skipCheck) > 0 {
		return slices.Contains(skipCheck, checkId)
	}
	return false

}

func moduleSkipBySeverity(module *ast.Module) bool {
	severities := getFilteredSeverities()

	// return if no annotations
	if len(module.Annotations) == 0 {
		return false
	}
	//check args check do not skip check if equal to moodule severity
	severity := module.Annotations[0].Custom["severity"].(string)
	if len(severities) > 0 {
		return !slices.Contains(severities, severity)
	}
	return false

}

func getFilteredSeverities() []string {
	blockSeverities := new([]string)
	severities := Severities
	criteria := Arguments.SeverityCriteria
	if *criteria == "" || len(*criteria) == 0 || !slices.Contains(severities, strings.ToUpper(*criteria)) {
		return *blockSeverities
	}

	index := -1
	for i, s := range severities {
		
		if strings.EqualFold(s, *criteria) {
			index = i
			break
		}
	}

	if index != -1 {
		// Block severities below the given severity
		return severities[index:]
	}

	return *blockSeverities
}

// add severity to summary
func countSeverity(severity string, IACResults *model.Result) {
	switch severity {
	case severityLow:
		IACResults.Summary.Low += 1
	case severityMedium:
		IACResults.Summary.Medium += 1
	case severityHigh:
		IACResults.Summary.High += 1
	case severityCritical:
		IACResults.Summary.Critical += 1
	}
}

// finalizeResults() is a function that finalizes count of failed and passed checks for each IAC configuration file
func finalizeResults(IACResults *model.Result) {
	IACResults.Summary.Failed = len(IACResults.FailedChecks)
	IACResults.Summary.Passed = len(IACResults.PassedChecks)
}
