package file

import (
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
	// Read Dockerfile content
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
	var currentInstruction DockerInstruction

	for i, line := range lines {
		// Skip lines starting with a hash symbol (comments)
		if strings.HasPrefix(strings.TrimSpace(line), "#") {
			continue
		}
		match := re.FindStringSubmatch(line)
		if match != nil {
			if currentInstruction.Instruction != "" {
				// If a new instruction is found, append the current instruction to the list
				dockerInstructions = append(dockerInstructions, currentInstruction)
			}

			instruction := match[1]
			args := strings.Fields(match[2])

			currentStartLine = i + 1
			currentInstruction = DockerInstruction{
				LineRange: LineRange{
					StartLine: currentStartLine,
					EndLine:   currentStartLine,
				},
				Instruction: instruction,
				Args:        args,
			}
		} else if currentInstruction.Instruction != "" {
			// If we are in a multi-line instruction, append the line to args
			currentInstruction.Args = append(currentInstruction.Args, strings.Fields(strings.TrimSpace(line))...)
			currentInstruction.LineRange.EndLine = i + 1
		}
	}

	// Append the last instruction if it exists
	if currentInstruction.Instruction != "" {
		dockerInstructions = append(dockerInstructions, currentInstruction)
	}

	var interfaceResult interface{} = dockerInstructions
	return interfaceResult, rawContent
}
