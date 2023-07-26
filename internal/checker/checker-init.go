package checker

import (
	"github.com/carbonetes/brainiac/pkg/model"
)

var (
	Arguments *model.Arguments
	Errors    []*error
)

// InitParsers initialize arguments
func InitChecker(argument model.Arguments) {
	Arguments = &argument
}
