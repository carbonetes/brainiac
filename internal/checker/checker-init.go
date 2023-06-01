package checker

import (
	"github.com/carbonetes/brainiac/internal/model"
)

var (
	// IACResults - common collection of checks
	IACArrayResults = make([]*model.Result, 0)
	// Arguments - CLI Arguments
	Arguments *model.Arguments
	// IACResults - common collection of checks
	IACResults = new(model.Result)
	//collected errors for the checker if any
	Errors []*error
)

// InitParsers initialize arguments
func InitChecker(argument model.Arguments) {
	Arguments = &argument
}
