package analysis

import (
	"github.com/carbonetes/brainiac/internal/checker"
	"github.com/carbonetes/brainiac/internal/engine"
	"github.com/carbonetes/brainiac/pkg/model"
)

// scan single file
func ScanIAC(arguments *model.Arguments) (model.Result, error) {
	//init Checker arguments
	checker.InitChecker(*arguments)
	return engine.ProcessSingleFile(arguments)
}

// scan directory
func ScanDIR(arguments *model.Arguments) ([]*model.Result, []*error) {
	checker.InitChecker(*arguments)
	return engine.ProcessFileList(arguments)
}
