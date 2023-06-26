package module

import (
	"embed"
	"path/filepath"
	"strings"

	"github.com/open-policy-agent/opa/ast"
	"github.com/open-policy-agent/opa/bundle"
)

func ModuleParser(platform string, fs embed.FS) (map[string]*ast.Module, error) {

	modules := make(map[string]*ast.Module)
	fileDirectory, err := fs.ReadDir(filepath.ToSlash(platform))

	if err != nil {
		return nil, err
	}
	for _, file := range fileDirectory {
		if file.IsDir() {
			subDirModule, err := ModuleParser(platform+"/"+file.Name(), fs)
			if err != nil {
				return nil, err
			}
			for key, val := range subDirModule {
				modules[key] = val
			}
			continue
		}
		//skip file if not rego
		if !strings.HasSuffix(file.Name(), bundle.RegoExt) || strings.HasSuffix(file.Name(), "_test"+bundle.RegoExt) {
			continue
		}
		fullPath := platform + "/" + file.Name()
		content, err := fs.ReadFile(fullPath)
		if err != nil {
			return nil, err
		}
		module, err := ast.ParseModuleWithOpts(fullPath, string(content), ast.ParserOptions{ProcessAnnotation: true})
		if err != nil {
			return nil, err
		}
		modules[fullPath] = module
	}
	return modules, err
}
