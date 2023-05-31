// Package cmd Copyright © 2022 Carbonetes eng@carbonetes.com
package brainiac

import (
	"os"
)

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := brainiac.Execute()
	if err != nil {
		os.Exit(1)
	}
}
