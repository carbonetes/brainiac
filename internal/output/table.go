package output

import (
	"fmt"
	"sort"
	"strings"

	"github.com/carbonetes/brainiac/internal/checker"

	"github.com/gdamore/tcell/v2"
)

func printDirTable() {
	// Extract the terminal width from the size array
	width := getTerminalWidth()

	// Define ANSI escape codes for colors
	for _, results := range checker.IACArrayResults {
		// Sort Checks by empty code block
		sort.Slice(results.FailedChecks, func(i, j int) bool {
			if results.FailedChecks[i].CodeBlock == nil && results.FailedChecks[j].CodeBlock != nil {
				return true
			}
			return false
		})

		stringTableFormat("Check type: ", reset, 0)
		stringTableFormat(results.CheckType, blue, 2)
		stringTableFormat(fmt.Sprintf("Test runs: %v", len(results.FailedChecks)+len(results.PassedChecks)), reset, 0)
		fmt.Printf("%s  PASSED:%s %v", green, reset, results.Summary.Passed)
		fmt.Printf("%s  FAILED:%s %v\n", red, reset, results.Summary.Failed)
		fmt.Printf("Failed checks: %v (LOW: %v,   MEDIUM: %v,  HIGH: %v, CRITICAL: %v)\n\n", results.Summary.Failed, results.Summary.Low, results.Summary.Medium, results.Summary.High, results.Summary.Critical)

		for _, check := range results.FailedChecks {
			fmt.Printf("%s: %s\n", formatSeverity(check.Severity), check.Title)
			tableSpacer("═", 1, width)
			stringTableFormat(check.Description, dimWhite, 2)
			stringTableFormat("Reference: "+check.Reference, dimWhite, 1)
			tableSpacer("─", 1, width)
			fmt.Printf("Check: ")
			stringTableFormat(check.ID, yellow, 0)
			fmt.Printf(" │ File: ")
			stringTableFormat(check.Path, blue, 1)
			if check.CodeBlock != nil {
				tableSpacer("─", 1, width)
				for index, code := range check.CodeBlock {
					// TODO: add suggested fix and affected line
					if index == 0 && len(check.CodeBlock) > 1 {
						fmt.Printf(" %s%s%s %s┌%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
					} else if index == len(check.CodeBlock)-1 && len(check.CodeBlock) > 1 {
						fmt.Printf(" %s%s%s %s└%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
					} else {
						fmt.Printf(" %s%s%s %s│%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
					}
				}
				tableSpacer("─", 3, width)
			} else {
				tableSpacer("─", 3, width)
			}
		}
	}
}

func printFileTable() {
	// Extract the terminal width from the size array
	width := getTerminalWidth()

	// Sort Checks by empty code block
	sort.Slice(checker.IACResults.FailedChecks, func(i, j int) bool {
		if checker.IACResults.FailedChecks[i].CodeBlock == nil && checker.IACResults.FailedChecks[j].CodeBlock != nil {
			return true
		}
		return false
	})

	stringTableFormat("Check type: ", reset, 0)
	stringTableFormat(checker.IACResults.CheckType, blue, 2)
	stringTableFormat(fmt.Sprintf("Test runs: %v", len(checker.IACResults.FailedChecks)+len(checker.IACResults.PassedChecks)), reset, 0)
	fmt.Printf("%s  PASSED:%s %v", green, reset, checker.IACResults.Summary.Passed)
	fmt.Printf("%s  FAILED:%s %v\n", red, reset, checker.IACResults.Summary.Failed)
	fmt.Printf("Failed checks: %v (LOW: %v,   MEDIUM: %v,  HIGH: %v, CRITICAL: %v)\n\n", checker.IACResults.Summary.Failed, checker.IACResults.Summary.Low, checker.IACResults.Summary.Medium, checker.IACResults.Summary.High, checker.IACResults.Summary.Critical)

	for _, check := range checker.IACResults.FailedChecks {
		fmt.Printf("%s: %s\n", formatSeverity(check.Severity), check.Title)
		tableSpacer("═", 1, width)
		stringTableFormat(check.Description, dimWhite, 2)
		stringTableFormat("Reference : "+check.Reference, dimWhite, 1)
		tableSpacer("─", 1, width)
		fmt.Printf("Check: ")
		stringTableFormat(check.ID, yellow, 0)
		fmt.Printf(" │ File: ")
		stringTableFormat(check.Path, blue, 1)
		if check.CodeBlock != nil {
			tableSpacer("─", 1, width)
			for index, code := range check.CodeBlock {
				// TODO: add suggested fix and affected line
				if index == 0 && len(check.CodeBlock) > 1 {
					fmt.Printf(" %s%s%s %s┌%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
				} else if index == len(check.CodeBlock)-1 && len(check.CodeBlock) > 1 {
					fmt.Printf(" %s%s%s %s└%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
				} else {
					fmt.Printf(" %s%s%s %s│%s %s\n", blue, fmt.Sprintf("%s%s", strings.Repeat(" ", len(check.CodeBlock[len(check.CodeBlock)-1][0])-len(code[0])), code[0]), reset, reset, reset, code[1])
				}
			}
			tableSpacer("─", 3, width)
		} else {
			tableSpacer("─", 3, width)
		}
	}
}

func formatSeverity(severity string) string {
	var color string

	switch severity {
	case severityMedium:
		color = yellow
	case severityHigh:
		color = orange
	case severityCritical:
		color = red
	default:
		color = reset
	}

	return fmt.Sprintf("%s%s%s", color, severity, reset)
}

func tableSpacer(spacerSymbol string, newline int, width int) {
	fmt.Printf("%s%s%s%s", dimWhite, strings.Repeat(spacerSymbol, width-1), reset, strings.Repeat("\n", newline))
}

func stringTableFormat(tableString string, color string, newline int) {
	fmt.Printf("%s%s%s%s", color, tableString, reset, strings.Repeat("\n", newline))
}

func getTerminalWidth() int {
	// Initialize the terminal screen
	screen, err := tcell.NewScreen()
	if err != nil {
		panic(err)
	}
	if err := screen.Init(); err != nil {
		panic(err)
	}
	defer screen.Fini()

	// Get the terminal width
	width, _ := screen.Size()
	return width
}
