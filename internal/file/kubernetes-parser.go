package file

import (
	"os"
	"strconv"
	"strings"

	"github.com/open-policy-agent/opa/bundle"
	"gopkg.in/yaml.v3"
)

// parse kubernetes config
func ParseKubernetesFile(configFile string) (interface{}, string) {

	file, _ := os.ReadFile(configFile)
	rawContent := string(file)
	var result yamlRes

	if err := yaml.Unmarshal([]byte(file), &result); err != nil {
		return nil, ""
	}
	if result.Content != nil {
		return result.Content.convertToInterface(), rawContent
	}
	return nil, ""

}
func GenerateClass(path string) string {
	newPath := strings.ReplaceAll(path, string(os.PathSeparator), ".")
	return toolScheme + "." + strings.Split(newPath, bundle.RegoExt)[0]
}

// use interface of yaml unmarshal to custom it.
func (res *yamlRes) UnmarshalYAML(value *yaml.Node) error {
	if value.Tag == TypeMap {
		node := new(yamlNode)
		if err := value.Decode(node); err != nil {
			return err
		}
		res.Content = node
	}
	return nil
}

func (res *yamlNode) UnmarshalYAML(node *yaml.Node) error {

	res.StartLine = node.Line
	res.EndLine = node.Line
	res.Type = node.Tag
	switch node.Tag {
	case TypeString, TypeStr:
		res.Value = node.Value
	case TypeInt:
		res.Value, _ = strconv.Atoi(node.Value)
	case TypeFloat:
		res.Value, _ = strconv.ParseFloat(node.Value, 64)
	case TypeBool:
		res.Value, _ = strconv.ParseBool(node.Value)
	case TypeMap:
		return res.parseTypeMap(node)
	case TypeSlice:
		return res.parseTypeSlice(node)
	default:
		res.Value = node.Value
	}
	return nil
}

func (res *yamlNode) convertToInterface() interface{} {
	switch res.Type {
	case TypeSlice:
		var obj []interface{}
		for _, node := range res.Value.([]yamlNode) {
			obj = append(obj, node.convertToInterface())
		}
		return obj
	case TypeMap:
		obj := make(map[string]interface{})
		obj["line_range"] = map[string]interface{}{
			"startLine": res.StartLine,
			"endLine":   res.EndLine,
		}
		for key, node := range res.Value.(map[string]yamlNode) {
			obj[key] = node.convertToInterface()
		}
		return obj
	default:
		return res.Value
	}
}

func (res *yamlNode) parseTypeSlice(node *yaml.Node) error {
	var nodes []yamlNode
	maxLine := node.Line
	for _, contentNode := range node.Content {
		obj := new(yamlNode)
		if err := contentNode.Decode(obj); err != nil {
			return err
		}
		if obj.EndLine > maxLine {
			maxLine = obj.EndLine
		}
		nodes = append(nodes, *obj)
	}
	res.EndLine = maxLine
	res.Value = nodes
	return nil
}

func (res *yamlNode) parseTypeMap(node *yaml.Node) error {

	mapObj := make(map[string]yamlNode)
	var key string
	max := node.Line
	for i, content := range node.Content {
		if i%2 == 0 {
			key = content.Value
		} else {
			obj := new(yamlNode)
			if err := content.Decode(obj); err != nil {
				return err
			}
			mapObj[key] = *obj
			if obj.EndLine > max {
				max = obj.EndLine
			}
		}
	}
	res.EndLine = max
	res.Value = mapObj
	return nil
}
