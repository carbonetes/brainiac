package file

import (
	"bytes"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/carbonetes/brainiac/pkg/model"

	"gopkg.in/yaml.v3"
)

const (
	FileTypeTerraform      string = "terraform"
	FileTypeDockerfile     string = "docker"
	FileTypeKubernetes     string = "kubernetes"
	FileTypeCloudFormation string = "cloudformation"
	FileTypeYAML           string = "yaml"
	FileTypeJSON           string = "json"
	FileTypeHelm           string = "helm"
	FileTypeAzureARM       string = "azure-arm"

	TypeSlice  string = "!!seq"
	TypeMap    string = "!!map"
	TypeBool   string = "!!bool"
	TypeInt    string = "!!int"
	TypeFloat  string = "!!float"
	TypeStr    string = "!!str"
	TypeString string = "!!string"

	toolScheme = "brainiac"
)

// custom node for Yaml
type yamlNode struct {
	StartLine int
	EndLine   int
	Value     interface{}
	Type      string
}

// custom result for yaml
type yamlRes struct {
	Content *yamlNode
}

func ConfigType(file string) string {
	if isKubernetes(file) {
		return FileTypeKubernetes
	}

	if isDockerfile(file) {
		return FileTypeDockerfile
	}

	if isTerraform(file) {
		return FileTypeTerraform
	}

	if isCloudFormation(file) {
		return FileTypeCloudFormation
	}
	return ""
}

// Exists checks if filename exists
func Exists(filename string) bool {
	if _, err := os.Stat(filename); err == nil {
		return true
	}
	return false
}

// check if file extension is yaml
func isYAML(fileExtension string) bool {
	return strings.EqualFold(fileExtension, ".yaml") || strings.EqualFold(fileExtension, ".yml")
}

// check if file extension is json
func isJSON(fileExtension string) bool {
	return strings.EqualFold(fileExtension, ".json")
}

// check if the file extension is terraform
func isTerraform(configFile string) bool {
	for _, ext := range []string{".tf", ".tf.json"} {
		if strings.HasSuffix(configFile, ext) {
			return true
		}
	}

	return false
}

// check if the config is dockerfile
func isDockerfile(configFile string) bool {

	commonFiles := []string{"Dockerfile", "Containerfile"}
	for _, commonFile := range commonFiles {
		base := filepath.Base(configFile)
		fileExtension := filepath.Ext(filepath.Base(configFile))
		if strings.TrimSuffix(base, fileExtension) == commonFile {
			return true
		}
		if strings.EqualFold(fileExtension, "."+commonFile) {
			return true
		}
	}
	return false

}

// check if the config is kubernetes
func isKubernetes(configFile string) bool {

	fileExtension := filepath.Ext(filepath.Base(configFile))
	file, _ := os.ReadFile(configFile)

	if !isYAML(fileExtension) && !isJSON(fileExtension) {
		return false
	}

	kubernetesProperties := []string{"apiVersion", "kind", "metadata"}

	if isJSON(fileExtension) {
		var k8sResult map[string]interface{}
		if err := json.Unmarshal(file, &k8sResult); err != nil {
			return false
		}

		for _, expected := range kubernetesProperties {
			if _, ok := k8sResult[expected]; !ok {
				return false
			}
		}
		return true
	}

	separator := "\n---\n"
	altSeparator := "\r\n---\r\n"
	if bytes.Contains(file, []byte(altSeparator)) {
		separator = altSeparator
	}

	//check if the yaml consist of partial resource
	for _, partial := range strings.Split(string(file), separator) {
		var result map[string]interface{}
		if err := yaml.Unmarshal([]byte(partial), &result); err != nil {
			continue
		}

		match := true
		for _, expected := range kubernetesProperties {
			if _, ok := result[expected]; !ok {
				match = false
				break
			}
		}
		if match {
			return true
		}
	}

	return false

}

func isCloudFormation(configFile string) bool {
	fileExtension := filepath.Ext(filepath.Base(configFile))
	file, _ := os.ReadFile(configFile)

	if !isYAML(fileExtension) && !isJSON(fileExtension) && fileExtension != ".template" {
		return false
	}

	if isJSON(fileExtension) || fileExtension == ".template" {
		var templateResult map[string]interface{}
		if err := json.Unmarshal(file, &templateResult); err != nil {
			return false
		}

		if _, ok := templateResult["Resources"]; ok {
			return true
		}
		return false
	}

	//if yaml
	var result map[string]interface{}
	if err := yaml.Unmarshal(file, &result); err != nil {
		return false
	}
	if _, ok := result["Resources"]; ok {
		return true
	}

	return false

}

// CheckUserInput evaluates specified arguments by user
func CheckUserInput(args *model.Arguments) string {
	if *args.File == "" && len(*args.Dir) > 0 {
		return "dir"
	} else if *args.File != "" && len(*args.Dir) == 0 {

		fileInfo, err := os.Stat(*args.File)
		if err != nil {
			fmt.Println("Error:", err)
			return "error"
		}

		mode := fileInfo.Mode()

		if mode.IsDir() {
			args.Dir = args.File
			return "dir"
		} else {
			return "file"
		}
	}

	return ""
}

func CheckDirectoryForIAC(dirPath string) []string {
	fileList := []string{}
	err := filepath.Walk(dirPath, func(path string, f os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !f.IsDir() && isIACFile(path) {
			fileList = append(fileList, path)
		}
		return nil
	})

	if err != nil {
		fmt.Println("Error:", err)
	}
	return fileList
}

func isIACFile(filePath string) bool {
	ext := filepath.Ext(filePath)
	switch ext {
	case ".tf", ".json", ".yml", ".yaml":
		return true
	default:
		return false
	}
}

func ConvertStringListToArray(input string) *[]string {
	var newList []string
	// return if input is blank
	if input == "" {
		return &newList
	}

	if strings.Contains(input, ",") {
		newList = append(newList, strings.Split(input, ",")...)
	} else {
		newList = append(newList, input)
	}
	return &newList
}
