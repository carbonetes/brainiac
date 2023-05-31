package file

import (
	"path/filepath"
	"testing"
)

func TestConfigType(t *testing.T) {
	type testCase struct {
		name string
		file string
		want string
	}

	// Define test cases for Terraform, Dockerfile, and Kubernetes
	tests := []testCase{
		{
			name: "Test ConfigType - File terraform",
			file: filepath.Join("Terraform", "main.tf"),
			want: "terraform",
		},
		{
			name: "Test ConfigType - File Dockerfile",
			file: filepath.Join("Docker", "Dockerfile"),
			want: "dockerfile",
		},
		{
			name: "Test ConfigType - File Kubernetes",
			file: filepath.Join("Kubernetes", "pod.yaml"),
			want: "kubernetes",
		},
	}

	// Loop through the test cases to test the function ConfigType and compare the result with the expected result
	for _, tc := range tests {
		t.Run(tc.name, func(t *testing.T) {
			// Call the ConfigType function to test the expected result
			if got := ConfigType(getPath(tc.file)); got != tc.want {
				t.Errorf("ConfigType() = %v, want %v", got, tc.want)
			}
		})
	}
}

func getPath(file string) string {
	parent := filepath.Join("..", "..", "docs")
	return filepath.Join(parent, file)
}
