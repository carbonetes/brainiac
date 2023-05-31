package model

// checks result
type Result struct {
	CheckType    string  `json:"CheckType"`
	FailedChecks []Check `json:"failedChecks"`
	PassedChecks []Check `json:"passedChecks"`
	Summary      Summary `json:"summary"`
}

type Check struct {
	ID          string      `json:"id"`
	Title       string      `json:"title"`
	Description string      `json:"description"`
	Message     string      `json:"message"`
	Path        string      `json:"path"`
	Resource    string      `json:"resource"`
	Class       string      `json:"class"`
	CheckResult string      `json:"checkResult"`
	Severity    string      `json:"severity"`
	Reference   string      `json:"reference"`
	LineRange   []string    `json:"lineRange"`
	CodeBlock   []CodeBlock `json:"codeBlock"`
}

type Summary struct {
	Failed   int `json:"failed"`
	Passed   int `json:"passed"`
	Low      int `json:"low"`
	Medium   int `json:"medium"`
	High     int `json:"high"`
	Critical int `json:"critical"`
}

type CodeBlock []string
