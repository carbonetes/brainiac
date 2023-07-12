package output

import (
	"encoding/json"
	"fmt"
	"strings"

	"github.com/carbonetes/brainiac/internal/checker"
	"github.com/carbonetes/brainiac/internal/logger"
	"github.com/carbonetes/brainiac/pkg/model"
)

var (
	log = logger.GetLogger()
)

const (
	severityLow      string = "LOW"
	severityMedium   string = "MEDIUM"
	severityHigh     string = "HIGH"
	severityCritical string = "CRITICAL"

	red      = "\033[31m"
	green    = "\033[32m"
	blue     = "\033[34m"
	yellow   = "\033[33m"
	orange   = "\033[38;5;208m"
	dimWhite = "\u001B[2m\u001B[37m"
	reset    = "\033[0m"
)

// PrintFileResults prints the result based on the arguments
func PrintFileResults() {
	outputTypes := strings.ToLower(checker.Arguments.Output.ToOutput())

	for _, output := range strings.Split(outputTypes, ",") {
		switch output {
		case model.Table:
			printFileTable()
		case model.JSON.ToOutput():
			printFileResults()
		}
	}
	if len(checker.Errors) > 0 {
		for _, err := range checker.Errors {
			log.Printf("[warning]: %+v\n", *err)
		}
	}
}

// PrintResults prints the result based on the arguments in json format
func PrintDirResults() {
	outputTypes := strings.ToLower(checker.Arguments.Output.ToOutput())

	for _, output := range strings.Split(outputTypes, ",") {
		switch output {
		case model.Table:
			printDirTable()
		case model.JSON.ToOutput():
			printListResults()
		}
	}

	if len(checker.Errors) > 0 {
		for _, err := range checker.Errors {
			log.Printf("[warning]: %+v\n", *err)
		}
	}
}

func printFileResults() {
	res, _ := json.MarshalIndent(checker.IACResults, "", " ")
	fmt.Println(string(res))
}
func printListResults() {
	res, _ := json.MarshalIndent(checker.IACArrayResults, "", " ")
	fmt.Println(string(res))
}
