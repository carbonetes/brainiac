package brainiac

import (
	"brainiac/internal/engine"
	"brainiac/internal/logger"
	"brainiac/internal/model"
	versionPackage "brainiac/internal/version"
	"encoding/json"
	"fmt"
	"os"
	"strings"

	"github.com/spf13/cobra"
)

var (
	log         = logger.GetLogger()
	help        bool            // help flag
	tableOutput                 = []string{"table"}
	outputArray                 = new([]string)
	Arguments   model.Arguments = model.Arguments{
		File: new(string),
		Dir:  new(string),
	}
	versionOutputFormat string
	versionArg          bool
	// Arguments is an instance of the actual arguments passed

	brainiac = &cobra.Command{
		Use:   "brainiac",
		Args:  cobra.MaximumNArgs(1),
		Short: "IAC Configuration Analyzer",
		Long:  `Analyze your Infrastructure as code.`,
		PreRun: func(cmd *cobra.Command, args []string) {
			if len(args) == 0 && !flagHasArg() {
				_ = cmd.Help()
				os.Exit(0)
			}
			ValidateOutputArg(string(*Arguments.Output))
		},
		Run: func(cmd *cobra.Command, args []string) {

			if len(args) > 0 {
				if flagHasArg() {
					log.Println(`"brainiac [-d, --dir]" does not support with argument file`)
					os.Exit(127)
				}
				Arguments.File = &args[0]
			} else if len(args) == 0 && flagHasArg() {
				//continue to start
			} else if len(args) == 0 && !flagHasArg() {
				log.Printf(`"brainiac [-f, --file]" is required or at least 1 argument "brainiac [file]"`)
				os.Exit(127)
			}
			engine.Start(&Arguments)
		},
	}

	version = &cobra.Command{
		Use:   "version",
		Short: "Display Build Version Info brainiac",
		Long:  "Display Build Version Info brainiac",
		Args:  cobra.MaximumNArgs(0),
		RunE: func(_ *cobra.Command, _ []string) error {

			versionInfo := versionPackage.FromBuild()
			switch versionOutputFormat {
			case "text":
				// Version
				fmt.Println("Application:         ", versionInfo.AppName)
				fmt.Println("Version:             ", versionInfo.Version)
				fmt.Println("Build Date:          ", versionInfo.BuildDate)
				// Git
				fmt.Println("Git Commit:          ", versionInfo.GitCommit)
				fmt.Println("Git Description:     ", versionInfo.GitDesc)
				// Golang
				fmt.Println("Go Version:          ", versionInfo.GoVersion)
				fmt.Println("Compiler:            ", versionInfo.Compiler)
				fmt.Println("Platform:            ", versionInfo.Platform)
			case "json":

				jsonFormat := json.NewEncoder(os.Stdout)
				jsonFormat.SetEscapeHTML(false)
				jsonFormat.SetIndent("", " ")
				err := jsonFormat.Encode(&struct {
					model.Version
				}{
					Version: versionInfo,
				})
				if err != nil {
					return fmt.Errorf("show version information error: %+v", err)
				}
			default:
				return fmt.Errorf("unrecognize output format: %s", versionOutputFormat)
			}
			return nil
		},
	}
)

func init() {
	brainiac.Flags().BoolVarP(&help, "help", "h", false, "Help for brainiac")
	brainiac.Flags().StringVarP(Arguments.File, "file", "f", "", "File to scan")
	brainiac.Flags().BoolVarP(&versionArg, "version", "v", false, "Display brainiac version")
	brainiac.Flags().StringVarP(Arguments.Dir, "dir", "d", "", "Read directly from a path on disk (any directory) (e.g. 'brainiac -d path/to/dir)' (can not be used together with --file).")
	brainiac.Flags().StringArrayVarP(outputArray, "output", "o", tableOutput, "Format to display results (table, json)")

	// version flags
	version.Flags().StringVarP(&versionOutputFormat, "output", "o", "text", "Format to display results ([text, json])")
	version.Flags().BoolVarP(&help, "help", "h", false, "Help for version")

	brainiac.AddCommand(version)
	brainiac.CompletionOptions.DisableDefaultCmd = true

	cobra.OnInitialize(setPrioritizedArg)
}

// Check if flag has dir or tar arguments
func flagHasArg() bool {
	return len(*Arguments.File) != 0 || len(*Arguments.Dir) != 0
}

func setPrioritizedArg() {
	if versionArg {
		log.Printf("brainiac %s", versionPackage.FromBuild().Version)
		os.Exit(0)
	}

	// Set values from flags, if applicable
	setArrayArgs()
}

func setArrayArgs() {
	// Set output from flags
	output := strings.Join(*outputArray, ",")
	Arguments.Output = (*model.Output)(&output)
	// set for future array flags
}

// ValidateOutputArg checks if output types specified are valid
func ValidateOutputArg(outputType string) {
	for _, output := range strings.Split(outputType, ",") {
		if _, ok := model.OutputTypes[strings.ToLower(output)]; !ok {
			log.Printf("[warning]: Invalid output type: %+v \nSupported output types: [json, table]", output)
			os.Exit(0)
		}
	}
}
