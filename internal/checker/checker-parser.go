package checker

import (
	"encoding/json"
	"strconv"
	"strings"

	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/internal/model"

	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/rego"
)

func parseRegoResult(result rego.ResultSet, module *ast.Module, configFile string, rawContent string) {

	mapResult := result[0].Expressions[0].Value.(map[string]interface{})

	//return if both checks is null
	if len(mapResult["failed"].([]interface{})) == 0 && len(mapResult["passed"].([]interface{})) == 0 {
		return
	}

	var isFailed bool = false
	if len(mapResult["failed"].([]interface{})) > 0 {
		isFailed = true
	}

	//init check
	_check := new(model.Check)
	_check.Title = module.Annotations[0].Title
	_check.Severity = module.Annotations[0].Custom["severity"].(string)
	_check.Description = module.Annotations[0].Description
	_check.Path = configFile
	_check.Class = file.GenerateClass(module.Package.Location.File)

	//check for attrib resource
	if val, ok := mapResult["resource"].(string); ok {
		_check.Resource = val
	}
	if val, ok := mapResult["resource"].([]interface{}); ok {
		if len(val) > 0 {
			_check.Resource = val[0].(string)
		}
	}

	updateChecks(_check, module.Annotations[0].Custom)
	getReference(_check, module.Annotations[0].RelatedResources)
	if isFailed {
		//append to failed
		_check.CheckResult = failedCheck
		countSeverity(_check.Severity)
		getResult(mapResult["failed"].([]interface{}), _check, rawContent)
		IACResults.FailedChecks = append(IACResults.FailedChecks, *_check)
	} else {
		//append to passed
		_check.CheckResult = passedCheck
		getResult(mapResult["passed"].([]interface{}), _check, rawContent)
		IACResults.PassedChecks = append(IACResults.PassedChecks, *_check)
	}

}

// update check linerange and codeblock
func updateLineRangeAndCodeBlock(_check *model.Check, configSnippet map[string]interface{}, rawContents string) {
	if configSnippet == nil {
		return
	}
	if configSnippet["line_range"] != nil {
		lineRange := configSnippet["line_range"].(map[string]interface{})
		startLine := lineRange["startLine"].(json.Number).String()
		endline := lineRange["endLine"].(json.Number).String()

		_check.LineRange = append(_check.LineRange, startLine)
		_check.LineRange = append(_check.LineRange, endline)
		intStartLine, _ := strconv.Atoi(startLine)
		intEndline, _ := strconv.Atoi(endline)
		for i, lineContent := range strings.Split(rawContents, "\n") {
			index := i + 1
			if index >= intStartLine && index <= intEndline {
				codeBlock := model.CodeBlock{strconv.Itoa(index), lineContent}
				_check.CodeBlock = append(_check.CodeBlock, codeBlock)
			}
		}

	}
}

// get message from result
func getResult(Expressions []interface{}, _check *model.Check, rawContent string) {
	if val, ok := Expressions[0].(string); ok {
		_check.Message = val
	}
	if val, ok := Expressions[0].(map[string]interface{}); ok {
		_check.Message = val["message"].(string)
		if val, ok := val["snippet"].(map[string]interface{}); ok {
			updateLineRangeAndCodeBlock(_check, val, rawContent)
		}
	}

}

// add severity to summary
func countSeverity(severity string) {
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

// get related resource from annotation
func getReference(_check *model.Check, relatedResources []*ast.RelatedResourceAnnotation) {
	for _, relatedResource := range relatedResources {
		_check.Reference = relatedResource.Ref.String()
	}
}

// update checks from module custom source
func updateChecks(_check *model.Check, custom map[string]interface{}) {
	if val, ok := custom["id"].(string); ok {
		_check.ID = val
	}
	if val, ok := custom["severity"].(string); ok {
		_check.Severity = val
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
