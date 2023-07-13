package brainiac

import (
	"fmt"

	"github.com/carbonetes/brainiac/internal/logger"
	"github.com/carbonetes/brainiac/pkg/model"
	"github.com/spf13/cobra"
)

var (
	log         = logger.GetLogger()
	help        bool            // help flag
	tableOutput                 = []string{"table"}
	outputArray                 = new([]string)
	check                       = new(string)
	skipCheck                   = new(string)
	Arguments   model.Arguments = model.Arguments{
		File:             new(string),
		Dir:              new(string),
		Check:            new([]string),
		SkipCheck:        new([]string),
		SeverityCriteria: new(string),
	}
	versionOutputFormat string
	versionArg          bool
	Severities          = []string{
		"low",
		"medium",
		"high",
		"critical",
	}
)

func init() {
	brainiac.Flags().BoolVarP(&help, "help", "h", false, "Help for BrainIAC")
	version.Flags().BoolVarP(&help, "help", "h", false, "Help for version")

	//brainiac flags
	brainiac.Flags().StringVarP(Arguments.File, "file", "f", "", "File to scan")
	brainiac.Flags().StringVarP(Arguments.Dir, "dir", "d", "", "Read directly from a path on disk (any directory) (e.g. 'brainiac -d path/to/dir)' (can not be used together with --file).")
	brainiac.Flags().StringArrayVarP(outputArray, "output", "o", tableOutput, "Format to display results (table, json)")
	brainiac.Flags().BoolVarP(&versionArg, "version", "v", false, "Display BrainIAC version")
	brainiac.Flags().StringVar(Arguments.SeverityCriteria, "severity-criteria", "", fmt.Sprintf("This is used to specify the severity level for filtering results. Only checks with a severity equal to or higher than the specified criteria will be included.(%v)", Severities))
	brainiac.Flags().StringVarP(check, "check", "c", "", "Each item should be a BrainIAC check ID(CB_K8S_023), and you can enter multiple items separated by commas. Only the specified checks will be executed, and any other checks will be skipped.")
	brainiac.Flags().StringVar(skipCheck, "skip-check", "", "The same behavior applies to the --check flag, where you can enter multiple items separated by commas. However, only the specified checks will be skipped, and all other checks will be executed.")
	// version flags
	version.Flags().StringVarP(&versionOutputFormat, "output", "o", "text", "Format to display results ([text, json])")

	brainiac.AddCommand(version)
	brainiac.Flags().SortFlags = false
	// indentFlagDescriptions()
	cobra.OnInitialize(setPrioritizedArg)
}
