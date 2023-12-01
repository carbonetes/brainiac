package file

import (
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strings"
)

// DockerInstruction represents a Dockerfile instruction in JSON format

type DockerInstruction struct {
	LineRange   LineRange `json:"line_range"`
	Instruction string    `json:"instruction"`
	Args        []string  `json:"args"`
}

type LineRange struct {
	StartLine int `json:"startLine"`
	EndLine   int `json:"endLine"`
}

func ParseDockerfile(filename string) (interface{}, string) {
	// Read Terraform file content
	content, err := os.ReadFile(filename)
	if err != nil {
		fmt.Println("Failed to read Dockerfile:", err)
	}
	rawContent := string(content)
	// Split Dockerfile content into lines
	lines := strings.Split(rawContent, "\n")

	// Define a regular expression to extract instruction and arguments
	re := regexp.MustCompile(`^([A-Z]+)\s*(.*)$`)

	var dockerInstructions []DockerInstruction

	var currentStartLine int

	for i, line := range lines {
		match := re.FindStringSubmatch(line)
		if match != nil {
			instruction := match[1]
			args := strings.Fields(match[2])

			currentStartLine = i + 1

			dockerInstructions = append(dockerInstructions, DockerInstruction{
				LineRange: LineRange{
					StartLine: currentStartLine,
					EndLine:   currentStartLine,
				},
				Instruction: instruction,
				Args:        args,
			})
		}
	}

	// Convert Docker instructions to JSON
	jsonData, err := json.MarshalIndent(dockerInstructions, "", "    ")
	if err != nil {
		fmt.Println("Error encoding JSON:", err)
	}

	// Print the JSON representation
	fmt.Println(string(jsonData))

	var interfaceResult interface{} = dockerInstructions
	return interfaceResult, rawContent
}
