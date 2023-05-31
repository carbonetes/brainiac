package file

import (
	"fmt"
	"io/ioutil"
	"log"
	"path/filepath"
	"testing"
)

// ParseKubernetesFile parses a Kubernetes file from docs/Kuberenetes and returns the AST
func TestParseKubernetesFile(t *testing.T) {
	type args struct {
		configFile string
	}

	parent := ".." + string(filepath.Separator) + ".." + string(filepath.Separator) + "docs" + string(filepath.Separator) + "Kubernetes"

	fileList, err := getFileList(parent)
	if err != nil {
		log.Fatal(err)
	}

	tests := make([]struct {
		name     string
		args     args
		expected string
	}, len(fileList))

	for i, file := range fileList {
		tests[i] = struct {
			name     string
			args     args
			expected string
		}{
			name: fmt.Sprintf("Test ParseKubernetesFile - File %v", file),
			args: args{
				configFile: file,
			},
			expected: getFileContents(file),
		}
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			//Call the ParseKubernetesFile function to test from expected result
			_, result := ParseKubernetesFile(tt.args.configFile)
			if result != tt.expected {
				t.Errorf("\nExpected:\n%v, Result:\n%v", tt.expected, result)
			}
		})
	}

}

func getFileList(dirPath string) ([]string, error) {
	var fileList []string

	// Read the directory contents
	files, err := ioutil.ReadDir(dirPath)
	if err != nil {
		return nil, err
	}

	// Iterate over the files in the directory
	for _, file := range files {
		// Check if the file is not a directory and has a .yaml extension
		if !file.IsDir() && filepath.Ext(file.Name()) == ".yaml" {
			// Append the file path to the list
			filePath := filepath.Join(dirPath, file.Name())
			fileList = append(fileList, filePath)
		}
	}

	return fileList, nil
}

func getFileContents(filePath string) string {
	// Read file contents
	fileBytes, err := ioutil.ReadFile(filePath)
	if err != nil {
		log.Fatal(err)
	}

	// Convert bytes to string
	fileContents := string(fileBytes)
	return fileContents
}
