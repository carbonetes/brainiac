package engine

import (
	"os"

	"github.com/carbonetes/brainiac/internal/checker"
	"github.com/carbonetes/brainiac/internal/file"
	"github.com/carbonetes/brainiac/internal/logger"
	"github.com/carbonetes/brainiac/internal/output"
	"github.com/carbonetes/brainiac/pkg/model"
)

// Set up logger module instance
var log = logger.GetLogger()

// Constants for input types
const (
	inputFile string = "file"
	inputDir  string = "dir"
)

// Start is a function that begins IAC Analysis
func Start(arguments *model.Arguments) {
	//init Checker arguments
	checker.InitChecker(*arguments)

	// Determine the source of our inputs with CheckUserInput() within file package.
	// The function returns either "file" or "dir".
	source := file.CheckUserInput(arguments)

	switch source {
	case inputFile:
		// check if input file exists
		if !file.Exists(*arguments.File) {
			log.Println("File not found")
			os.Exit(1)
		}
		// process file
		ProcessSingleFile(arguments)
		// Print the final result summary for single file
		output.PrintFileResults()
	case inputDir:
		// check if input directory exists
		if !file.Exists(*arguments.Dir) {
			log.Println("Directory not found")
			os.Exit(1)
		}
		//process all the files found in the input directory
		ProcessFileList(arguments)
		// Print the final result summary for input directory
		output.PrintDirResults()
	}
}

// processSingleFile is a function that processes individual IAC configuration files
func ProcessSingleFile(arguments *model.Arguments) (model.Result, []*error) {

	// determine configuration file format
	config := file.ConfigType(*arguments.File)

	// if format is not detected, print error message and exit out of program
	if config == "" {
		log.Println("Platform not detected")
		os.Exit(1)
	}
	// Call CheckIACFile() from checker module to perform IAC analysis
	checker.CheckIACFile(config, *arguments.File)

	// finalize the results of the checker
	finalizeResults()

	//return results
	return *checker.IACResults, checker.Errors
}

// processFileList is a function that processes all IAC configuration files found in the input directory
func ProcessFileList(arguments *model.Arguments) ([]*model.Result, []*error) {

	// check if there IAC files in the input directory
	fileList := file.CheckDirectoryForIAC(*arguments.Dir)
	if len(fileList) == 0 {
		log.Println("No IAC files found in the directory")
		os.Exit(1)
	}

	// for every IAC file in our list of IAC files,
	// determine the configuration file format
	// and check the file contents using CheckIACFile()
	for _, iacFile := range fileList {
		config := file.ConfigType(iacFile)
		if config == "" {
			continue
		}
		checker.CheckIACFile(config, iacFile)

		// finalize the results of the checker
		finalizeResults()

		// append results to IACArrayResults slice within the checker module
		checker.IACArrayResults = append(checker.IACArrayResults, checker.IACResults)

		// clear the IACResults model for the next iteration of processSingleFile()
		checker.IACResults = new(model.Result)
	}

	return checker.IACArrayResults, checker.Errors
}

// finalizeResults() is a function that finalizes count of failed and passed checks for each IAC configuration file
func finalizeResults() {
	checker.IACResults.Summary.Failed = len(checker.IACResults.FailedChecks)
	checker.IACResults.Summary.Passed = len(checker.IACResults.PassedChecks)
}
