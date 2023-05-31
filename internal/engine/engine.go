package engine

import (
	"brainiac/internal/checker"
	"brainiac/internal/file"
	"brainiac/internal/logger"
	"brainiac/internal/model"
	"brainiac/internal/output"
	"os"
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
		processSingleFile(*arguments.File)
	case inputDir:
		// check if input directory exists
		if !file.Exists(*arguments.Dir) {
			log.Println("Directory not found")
			os.Exit(1)
		}
		// check if there IAC files in the input directory
		fileList := file.CheckDirectoryForIAC(*arguments.Dir)
		if len(fileList) == 0 {
			log.Println("No IAC files found in the directory")
			os.Exit(1)
		}
		//process all the files found in the input directory
		processFileList(fileList)
	}
}

// processSingleFile is a function that processes individual IAC configuration files
func processSingleFile(filePath string) {

	// determine configuration file format
	config := file.ConfigType(filePath)

	// if format is not detected, print error message and exit out of program
	if config == "" {
		log.Println("Platform not detected")
		os.Exit(1)
	}
	// Call CheckIACFile() from checker module to perform IAC analysis
	checker.CheckIACFile(config, filePath)

	// finalize the results of the checker
	finalizeResults()

	// Print the final result summary for single file
	output.PrintFileResults()
}

// processFileList is a function that processes all IAC configuration files found in the input directory
func processFileList(fileList []string) {

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

	// Print the final result summary for input directory
	output.PrintDirResults()
}

// finalizeResults() is a function that finalizes count of failed and passed checks for each IAC configuration file
func finalizeResults() {
	checker.IACResults.Summary.Failed = len(checker.IACResults.FailedChecks)
	checker.IACResults.Summary.Passed = len(checker.IACResults.PassedChecks)
}
