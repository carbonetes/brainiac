package engine

import (
	"fmt"
	"path/filepath"
	"testing"

	"github.com/carbonetes/brainiac/internal/checker"
	"github.com/carbonetes/brainiac/internal/model"
)

func TestStart(t *testing.T) {
	// Define input Kubernetes configuration file
	parent := ".." + string(filepath.Separator) + ".." + string(filepath.Separator) + "docs" + string(filepath.Separator) + "Kubernetes" + string(filepath.Separator)

	// Define test cases
	args := []*model.Arguments{
		{
			File:   func() *string { s := parent + "pod.yaml"; return &s }(),
			Output: func() *model.Output { o := model.Output("-f"); return &o }(),
			Dir:    func() *string { s := ""; return &s }(),
		},
		{
			File:   func() *string { s := ""; return &s }(),
			Output: func() *model.Output { o := model.Output("-d"); return &o }(),
			Dir:    &parent,
		},
	}

	// Loop through test cases
	for _, tt := range args {
		t.Run(fmt.Sprintf("Test TestStart - output flag of %v", *tt.Output), func(t *testing.T) {
			// Call Start function
			Start(tt)

			// Check for output flag
			if *tt.Output == "-d" && len(checker.IACArrayResults) == 0 {
				t.Errorf("Expected IACResults to be populated, but it was empty")
			} else if *tt.Output == "-f" {
				// Check that the results model has been populated
				if checker.IACResults.PassedChecks == nil && checker.IACResults.FailedChecks == nil {
					t.Errorf("Expected IACResults to be populated, but it was empty")
				}

				// Check if CheckType field in IACResults has been set
				if checker.IACResults.CheckType == "" {
					t.Errorf("Expected to have CheckType, but it was empty")
				}
			}
		})
	}
}
