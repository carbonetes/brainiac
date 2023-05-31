package checker

import (
	"brainiac/internal/file"
	"brainiac/internal/logger"
	"context"
	"embed"
	"path/filepath"
	"strings"

	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/bundle"
	"github.com/open-policy-agent/opa/rego"
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
	log = logger.GetLogger()
)

// subject for modification once the research for rego is finish
func CheckIACFile(config, configFile string) {

	switch config {
	case file.FileTypeKubernetes:
		modules, err := ModuleParser(config, EmbededRules)
		if err != nil && modules == nil {
			log.Printf("Failed to parse rego modules")
			Errors = append(Errors, &err)
		}
		IACResults.CheckType = file.FileTypeKubernetes
		input, rawContent := file.ParseKubernetesFile(configFile)
		proccessInput(input, rawContent, modules, kubernetesBaseModule, configFile)
	case file.FileTypeTerraform:

		modules, err := ModuleParser(config, EmbededRules)
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

func ModuleParser(platform string, fs embed.FS) (map[string]*ast.Module, error) {

	modules := make(map[string]*ast.Module)
	fileDirectory, err := fs.ReadDir(filepath.ToSlash(platform))

	if err != nil {
		return nil, err
	}
	for _, file := range fileDirectory {
		if file.IsDir() {
			subDirModule, err := ModuleParser(platform+"/"+file.Name(), fs)
			if err != nil {
				return nil, err
			}
			for key, val := range subDirModule {
				modules[key] = val
			}
			continue
		}
		//skip file if not rego
		if !strings.HasSuffix(file.Name(), bundle.RegoExt) || strings.HasSuffix(file.Name(), "_test"+bundle.RegoExt) {
			continue
		}
		fullPath := platform + "/" + file.Name()
		content, err := fs.ReadFile(fullPath)
		if err != nil {
			return nil, err
		}
		module, err := ast.ParseModuleWithOpts(fullPath, string(content), ast.ParserOptions{ProcessAnnotation: true})
		if err != nil {
			return nil, err
		}
		modules[fullPath] = module
	}
	return modules, err
}

// Process input to query on list of modules
func proccessInput(input interface{}, rawContent string, modules map[string]*ast.Module, baseModule string, configFile string) {
	ctx := context.Background()
	//compile rego modules
	compiler := compileModules(modules)
	for _, module := range modules {
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
