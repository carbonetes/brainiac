package version

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
)

const placeholder = "not available"

// Build-time arguments, no values as default
var (
	appName, _  = os.Executable()
	baseAppName = filepath.Base(appName)
	version     = placeholder
	buildDate   = placeholder
	gitCommit   = placeholder
	gitDesc     = placeholder
	platform    = fmt.Sprintf("%s/%s", runtime.GOOS, runtime.GOARCH)
)

// FromBuild provides all version details
func FromBuild() Version {
	return Version{
		// Version
		AppName:   baseAppName,
		Version:   version,
		BuildDate: buildDate,
		// Git
		GitCommit: gitCommit,
		GitDesc:   gitDesc,
		// Golang
		GoVersion: runtime.Version(),
		Compiler:  runtime.Compiler,
		Platform:  platform,
	}
}
