package brainiac

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"

	"github.com/carbonetes/brainiac/internal/engine"
	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/internal/model"
	versionPackage "github.com/carbonetes/brainiac/internal/version"

	"github.com/spf13/cobra"
)

var (
	brainiac = &cobra.Command{
		Use:    "brainiac",
		Args:   cobra.MaximumNArgs(1),
		Short:  "IAC Configuration Analyzer",
		Long:   `Brainiac uses static code analysis to analyze IAC code to detect security issues before deployment. This tool can scan for issues like security policy misconfigurations, insecure cloud-based services, and compliance issues. The Brainiac tool performs a comprehensive code scan and generates reports containing detailed insights into the identified issues.`,
		PreRun: preRun,
		Run:    run,
	}

	version = &cobra.Command{
		Use:   "version",
		Short: "Display Build Version Info brainiac",
		Long:  "Display Build Version Info brainiac",
		Args:  cobra.MaximumNArgs(0),
		RunE:  runVersion,
	}
)

func run(cmd *cobra.Command, args []string) {

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
}

func preRun(cmd *cobra.Command, args []string) {
	if len(args) == 0 && !flagHasArg() {
		_ = cmd.Help()
		os.Exit(0)
	}
	ValidateOutputArg(string(*Arguments.Output))
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
	Arguments.Check = file.ConvertStringListToArray(*check)
	Arguments.SkipCheck = file.ConvertStringListToArray(*skipCheck)

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

func runVersion(_ *cobra.Command, _ []string) error {

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
}
