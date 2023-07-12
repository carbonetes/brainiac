package output

import (
	"path/filepath"
	"testing"

	"github.com/carbonetes/brainiac/internal/checker"
	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/pkg/model"
)

func TestPrintFileResults(t *testing.T) {
	configFile := ".." + string(filepath.Separator) + ".." + string(filepath.Separator) + "docs" + string(filepath.Separator) + "Kubernetes" + string(filepath.Separator) + "pod.yaml"

	args := &model.Arguments{
		File:             &configFile,
		Output:           func() *model.Output { o := model.Output("json"); return &o }(),
		Dir:              new(string),
		Check:            new([]string),
		SkipCheck:        new([]string),
		SeverityCriteria: new(string),
	}

	checker.Arguments = args
	config := file.ConfigType(configFile)
	checker.CheckIACFile(config, configFile)

	// Call the PrintFileResults() function to test if checker.Errors is empty
	PrintFileResults()

	if len(checker.Errors) != 0 {
		t.Errorf("Expected checker.Errors to be empty, but it was not")
	}
}

func TestPrintDirResults(t *testing.T) {
	parent := ".." + string(filepath.Separator) + ".." + string(filepath.Separator) + "docs" + string(filepath.Separator) + "Kubernetes" + string(filepath.Separator)

	args := &model.Arguments{
		File:             func() *string { s := ""; return &s }(),
		Output:           func() *model.Output { o := model.Output("json"); return &o }(),
		Dir:              &parent,
		Check:            new([]string),
		SkipCheck:        new([]string),
		SeverityCriteria: new(string),
	}

	checker.Arguments = args

	// Call CheckIACFile with Kubernetes config type and input file
	fileList := file.CheckDirectoryForIAC(*args.Dir)

	for _, iacFile := range fileList {
		config := file.ConfigType(iacFile)
		if config == "" {
			continue
		}

		checker.CheckIACFile(config, iacFile)

		// append results to IACArrayResults slice within the checker module
		checker.IACArrayResults = append(checker.IACArrayResults, checker.IACResults)

		// clear the IACResults model for the next iteration of processSingleFile()
		checker.IACResults = new(model.Result)
	}

	// Call the PrintDirResults() function to test if checker.Errors is empty
	PrintDirResults()

	if len(checker.Errors) != 0 {
		t.Errorf("Expected checker.Errors to be empty, but it was not")
	}
}
