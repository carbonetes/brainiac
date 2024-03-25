package file

import (
	"os"

	"gopkg.in/yaml.v3"
)

// parse Cloudformation config
func ParseAzureTemplateFile(configFile string) (interface{}, string) {

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
