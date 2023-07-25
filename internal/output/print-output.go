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
func PrintFileResults(res model.Result) {
	outputTypes := strings.ToLower(checker.Arguments.Output.ToOutput())

	for _, output := range strings.Split(outputTypes, ",") {
		switch output {
		case model.Table:
			printFileTable(res)
		case model.JSON.ToOutput():
			printFileResults(res)
		}
	}
	if len(checker.Errors) > 0 {
		for _, err := range checker.Errors {
			log.Printf("[warning]: %+v\n", *err)
		}
	}
}

// PrintResults prints the result based on the arguments in json format
func PrintDirResults(arrResult []*model.Result) {
	outputTypes := strings.ToLower(checker.Arguments.Output.ToOutput())

	for _, output := range strings.Split(outputTypes, ",") {
		switch output {
		case model.Table:
			printDirTable(arrResult)
		case model.JSON.ToOutput():
			printListResults(arrResult)
		}
	}

	if len(checker.Errors) > 0 {
		for _, err := range checker.Errors {
			log.Printf("[warning]: %+v\n", *err)
		}
	}
}

func printFileResults(res model.Result) {
	result, _ := json.MarshalIndent(res, "", " ")
	fmt.Println(string(result))
}
func printListResults(arrResult []*model.Result) {
	res, _ := json.MarshalIndent(arrResult, "", " ")
	fmt.Println(string(res))
}
