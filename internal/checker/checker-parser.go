package checker

import (
	"encoding/json"
	"strconv"
	"strings"

	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/pkg/model"

	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
)

func parseRegoResult(result rego.ResultSet, module *ast.Module, configFile string, rawContent string) (model.Check, error) {

	mapResult := result[0].Expressions[0].Value.(map[string]interface{})
	//innit checks
	check := new(model.Check)

	//return if both checks is null
	if len(mapResult["failed"].([]interface{})) == 0 && len(mapResult["passed"].([]interface{})) == 0 {
		return *check, nil
	}

	var isFailed bool = false
	if len(mapResult["failed"].([]interface{})) > 0 {
		isFailed = true
	}

	//init check

	check.Title = module.Annotations[0].Title
	check.Severity = module.Annotations[0].Custom["severity"].(string)
	check.Description = module.Annotations[0].Description
	check.Path = configFile
	check.Class = file.GenerateClass(module.Package.Location.File)

	//check for attrib resource
	if val, ok := mapResult["resource"].(string); ok {
		check.Resource = val
	}
	if val, ok := mapResult["resource"].([]interface{}); ok {
		if len(val) > 0 {
			check.Resource = val[0].(string)
		}
	}

	updateChecks(check, module.Annotations[0].Custom)
	getReference(check, module.Annotations[0].RelatedResources)
	if isFailed {
		//append to failed
		check.CheckResult = failedCheck
		getResult(mapResult["failed"].([]interface{}), check, rawContent)
	} else {
		//append to passed
		check.CheckResult = passedCheck
		getResult(mapResult["passed"].([]interface{}), check, rawContent)
	}
	return *check, nil
}

// update check linerange and codeblock
func updateLineRangeAndCodeBlock(check *model.Check, configSnippet map[string]interface{}, rawContents string) {
	if configSnippet == nil {
		return
	}
	if configSnippet["line_range"] != nil {
		lineRange := configSnippet["line_range"].(map[string]interface{})
		startLine := lineRange["startLine"].(json.Number).String()
		endline := lineRange["endLine"].(json.Number).String()

		check.LineRange = append(check.LineRange, startLine)
		check.LineRange = append(check.LineRange, endline)
		intStartLine, _ := strconv.Atoi(startLine)
		intEndline, _ := strconv.Atoi(endline)
		for i, lineContent := range strings.Split(rawContents, "\n") {
			index := i + 1
			if index >= intStartLine && index <= intEndline {
				codeBlock := model.CodeBlock{strconv.Itoa(index), lineContent}
				check.CodeBlock = append(check.CodeBlock, codeBlock)
			}
		}

	}
}

// get message from result
func getResult(Expressions []interface{}, check *model.Check, rawContent string) {
	if val, ok := Expressions[0].(string); ok {
		check.Message = val
	}
	if val, ok := Expressions[0].(map[string]interface{}); ok {
		check.Message = val["message"].(string)
		if val, ok := val["snippet"].(map[string]interface{}); ok {
			updateLineRangeAndCodeBlock(check, val, rawContent)
		}
	}

}

// get related resource from annotation
func getReference(check *model.Check, relatedResources []*ast.RelatedResourceAnnotation) {
	for _, relatedResource := range relatedResources {
		check.Reference = relatedResource.Ref.String()
	}
}

// update checks from module custom source
func updateChecks(check *model.Check, custom map[string]interface{}) {
	if val, ok := custom["id"].(string); ok {
		check.ID = val
	}
	if val, ok := custom["severity"].(string); ok {
		check.Severity = val
	}

}

// compile rego modules
func compileModules(modules map[string]*ast.Module) *ast.Compiler {
	compiler := ast.NewCompiler()
	compiler.Modules = modules
	compiler.WithCapabilities(nil)
	compiler.Compile(modules)
	if compiler.Failed() {
		log.Print(compiler.Errors)
		return nil
	}
	return compiler
}
