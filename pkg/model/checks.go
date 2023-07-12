package model

// checks result
type Result struct {
	CheckType    string  `json:"CheckType,omitempty"`
	FailedChecks []Check `json:"failedChecks,omitempty"`
	PassedChecks []Check `json:"passedChecks,omitempty"`
	Summary      Summary `json:"summary,omitempty"`
}

type Check struct {
	ID          string      `json:"id,omitempty"`
	Title       string      `json:"title,omitempty"`
	Description string      `json:"description,omitempty"`
	Message     string      `json:"message,omitempty"`
	Path        string      `json:"path,omitempty"`
	Resource    string      `json:"resource,omitempty"`
	Class       string      `json:"class,omitempty"`
	CheckResult string      `json:"checkResult,omitempty"`
	Severity    string      `json:"severity,omitempty"`
	Reference   string      `json:"reference,omitempty"`
	LineRange   []string    `json:"lineRange,omitempty"`
	CodeBlock   []CodeBlock `json:"codeBlock,omitempty"`
}

type Summary struct {
	Failed   int `json:"failed,omitempty"`
	Passed   int `json:"passed,omitempty"`
	Low      int `json:"low,omitempty"`
	Medium   int `json:"medium,omitempty"`
	High     int `json:"high,omitempty"`
	Critical int `json:"critical,omitempty"`
}

type CodeBlock []string
