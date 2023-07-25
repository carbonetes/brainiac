package engine

import (
	"errors"
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
		result, _ := ProcessSingleFile(arguments)
		// Print the final result summary for single file
		output.PrintFileResults(result)
	case inputDir:
		// check if input directory exists
		if !file.Exists(*arguments.Dir) {
			log.Println("Directory not found")
			os.Exit(1)
		}
		//process all the files found in the input directory
		arrayResults, _ := ProcessFileList(arguments)
		// Print the final result summary for input directory
		output.PrintDirResults(arrayResults)
	}
}

// processSingleFile is a function that processes individual IAC configuration files
func ProcessSingleFile(arguments *model.Arguments) (model.Result, error) {

	// determine configuration file format
	config := file.ConfigType(*arguments.File)

	// if format is not detected, print error message and exit out of program
	if config == "" {
		log.Fatal(errors.New("Platform not detected"))
	}
	// Call CheckIACFile() from checker module to perform IAC analysis
	return checker.CheckIACFile(config, *arguments.File)
}

// processFileList is a function that processes all IAC configuration files found in the input directory
func ProcessFileList(arguments *model.Arguments) ([]*model.Result, *[]error) {

	// innit array results
	var IACArrayResults = make([]*model.Result, 0)
	// check if there IAC files in the input directory
	fileList := file.CheckDirectoryForIAC(*arguments.Dir)
	if len(fileList) == 0 {
		log.Println("No IAC files found in the directory")
		os.Exit(1)
	}

	// for every IAC file in your list of IAC files,
	// determine the configuration file format
	// and check the file contents using CheckIACFile()
	for _, iacFile := range fileList {
		config := file.ConfigType(iacFile)
		if config == "" {
			continue
		}
		results, err := checker.CheckIACFile(config, iacFile)
		// append results to IACArrayResults slice within the checker module
		IACArrayResults = append(IACArrayResults, &results)
		if err != nil {
			checker.Errors = append(checker.Errors, &err)
		}
	}

	return IACArrayResults, nil
}
