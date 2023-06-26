package checker

import (
	"context"
	"embed"
	"strings"

	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/internal/logger"
	"github.com/carbonetes/brainiac/internal/module"
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

	kubernetesBaseModule = "data.lib.kubernetes"
	terraformBaseModule  = "data.lib.terraform"
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
func CheckIACFile(config, configFile string) {

	switch config {
	case file.FileTypeKubernetes:
		modules, err := module.ModuleParser(config, EmbededRules)
		if err != nil && modules == nil {
			log.Printf("Failed to parse rego modules")
			Errors = append(Errors, &err)
		}
		IACResults.CheckType = file.FileTypeKubernetes
		input, rawContent := file.ParseKubernetesFile(configFile)
		proccessInput(input, rawContent, modules, kubernetesBaseModule, configFile)
	case file.FileTypeTerraform:

		modules, err := module.ModuleParser(config, EmbededRules)
		if err != nil && modules == nil {
			log.Printf("Failed to parse rego modules")
			Errors = append(Errors, &err)
		}
		IACResults.CheckType = file.FileTypeTerraform
		input, rawContent := file.ParseTerraformFile(configFile)
		proccessInput(input, rawContent, modules, terraformBaseModule, configFile)

	case file.FileTypeDockerfile:

		IACResults.CheckType = file.FileTypeDockerfile
		//implement other config type here
	}

}

// Process input to query on list of modules
func proccessInput(input interface{}, rawContent string, modules map[string]*ast.Module, baseModule string, configFile string) {
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
			parseRegoResult(result, module, configFile, rawContent)
		}

	}
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
		if s == *criteria {
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
