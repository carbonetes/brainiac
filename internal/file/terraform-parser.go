package file

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"

	"github.com/hashicorp/hcl/v2"
	"github.com/hashicorp/hcl/v2/hclsyntax"
	"github.com/zclconf/go-cty/cty"
)

// Custom data structures to represent the Terraform file in an interface
type Resource struct {
	Type       string                 `json:"Type"`
	Labels     []string               `json:"Labels"`
	Attributes map[string]interface{} `json:"Attributes"`
	Blocks     []Resource             `json:"Blocks"`
	LineRange  map[string]interface{} `json:"line_range"`
}

// Recursive function to convert hclsyntax.Block to TerraformBlock
func convertBlock(block *hclsyntax.Block) Resource {
	labels := []string{}

	labels = append(labels, block.Labels...)

	//process found attributes
	attributes := processAtrributes(block.Body.Attributes)

	nestedBlocks := []Resource{}
	for _, block := range block.Body.Blocks {
		if block != nil {
			nestedBlocks = append(nestedBlocks, convertBlock(block))
		}
	}

	start := block.Body.Range().Start.Line
	end := block.Body.Range().End.Line
	return Resource{
		Type:       block.Type,
		Labels:     labels,
		Attributes: attributes,
		Blocks:     nestedBlocks,
		LineRange: map[string]interface{}{
			"startLine": start,
			"endLine":   end,
		},
	}
}

func processAtrributes(hclAttributes hclsyntax.Attributes) map[string]interface{} {

	attributes := make(map[string]interface{})
	for name, attr := range hclAttributes {
		val, diags := attr.Expr.Value(nil)
		if diags.HasErrors() {
			//check diag if traversal value
			if tval := checkDiag(diags); tval != "" {
				attributes[name] = tval
			}
			continue
		}
		valType := val.Type().FriendlyName()
		switch valType {
		case "string":
			attributes[name] = val.AsString()
		case "bool":
			attributes[name] = val.True()
		case "number":
			attributes[name] = val.AsBigFloat()
		case "tuple":
			if list := processTupleVal(val.AsValueSlice()); list != nil {
				attributes[name] = list
			}
		case "object":
			if obj := val.AsValueMap(); obj != nil {
				attributes[name] = processValueMap(obj)
			}
		default:
			//for implementation
		}

	}
	return attributes
}

func processValueMap(obj map[string]cty.Value) map[string]interface{} {
	if obj != nil {
		// Convert the map[string]cty.Value to interface{}
		interfaceObj := make(map[string]interface{})
		for k, v := range obj {
			valType := v.Type().FriendlyName()
			switch valType {
			case "string":
				interfaceObj[k] = v.AsString()
			case "bool":
				interfaceObj[k] = v.True()
			case "number":
				interfaceObj[k] = v.AsBigFloat()
			case "tuple":
				if list := processTupleVal(v.AsValueSlice()); list != nil {
					interfaceObj[k] = list
				}
			case "object":
				if obj := v.AsValueMap(); obj != nil {
					interfaceObj[k] = processValueMap(obj)
				}
			default:
				//for implementation
			}
		}
		return interfaceObj
	}
	return nil
}

func processTupleVal(tupleVal []cty.Value) interface{} {
	listTup := make([]map[string]string, 0)
	listArray := []string{}
	for _, elem := range tupleVal {
		if elem.IsKnown() {
			if elem.CanIterateElements() {
				elemObj := make(map[string]string)
				for k, v := range elem.AsValueMap() {
					elemObj[k] = v.AsString()
				}
				listTup = append(listTup, elemObj)
			} else {
				valType := elem.Type().FriendlyName()
				switch valType {
				case "string":
					listArray = append(listArray, elem.AsString())
				case "number":
					listArray = append(listArray, elem.AsBigFloat().String())
				}
			}
		}
	}
	if len(listTup) > 0 {
		return listTup
	} else if len(listArray) > 0 {
		return listArray
	}
	return nil
}

func checkDiag(diags hcl.Diagnostics) string {
	var sb strings.Builder
	switch expr := diags[0].Expression.(type) {
	case *hclsyntax.ScopeTraversalExpr:
		for i, cexpr := range expr.Traversal {
			if i > 0 {
				sb.WriteString(".")
			}
			if val, ok := cexpr.(hcl.TraverseRoot); ok {
				sb.WriteString(val.Name)
			}
			if val, ok := cexpr.(hcl.TraverseAttr); ok {
				sb.WriteString(val.Name)
			}
		}
	default:
		// Other expression types
	}
	return sb.String()
}

func ParseTerraformFile(filename string) (interface{}, string) {
	// Read Terraform file content
	content, err := os.ReadFile(filename)
	if err != nil {
		fmt.Println("Failed to read Terraform file:", err)
	}
	rawContent := string(content)

	// Parse Terraform file content into hclsyntax.File
	file, diags := hclsyntax.ParseConfig(content, "", hcl.Pos{Line: 1, Column: 1})
	if diags.HasErrors() {
		fmt.Println("Failed to parse Terraform file:", diags)
	}

	// Convert hclsyntax.File into custom interface
	terraformFile := []Resource{}
	for _, block := range file.Body.(*hclsyntax.Body).Blocks {
		if block != nil {
			terraformBlock := convertBlock(block)
			terraformFile = append(terraformFile, terraformBlock)
		}
	}

	var interfaceResult interface{} = terraformFile
	res, _ := json.MarshalIndent(interfaceResult, "", " ") // remove wheh merging to main
	fmt.Print(string(res))                                 // remove wheh merging to main
	return interfaceResult, rawContent
}
