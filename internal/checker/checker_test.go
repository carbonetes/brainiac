package checker

import (
	"path/filepath"
	"testing"

	"github.com/carbonetes/brainiac/internal/file"
)

func TestCheckIACFileKubernetes(t *testing.T) {
	// Define input Kubernetes configuration file
	configFile := ".." + string(filepath.Separator) + ".." + string(filepath.Separator) + "docs" + string(filepath.Separator) + "Kubernetes" + string(filepath.Separator) + "cronjob.yaml"
	// Call CheckIACFile with Kubernetes config type and input file
	CheckIACFile(file.FileTypeKubernetes, configFile)

	// Check that the IACResults model has been populated
	if len(IACResults.FailedChecks) == 0 && len(IACResults.PassedChecks) == 0 {
		t.Errorf("Expected IACResults to be populated, but it was empty")
	}

	// Check that CheckType field in IACResults has been set to Kubernetes
	if IACResults.CheckType != file.FileTypeKubernetes {
		t.Errorf("Expected CheckType to be Kubernetes, but got %v", IACResults.CheckType)
	}
}
