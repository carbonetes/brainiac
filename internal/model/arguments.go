package model

// Arguments - CLI Arguments
type Arguments struct {
	File   *string
	Output *Output
	Dir    *string
}

// Output type
type Output string

const (
	// JSON Output Type
	JSON Output = "json"
	// Table Output Type (Default)
	Table = "table"
)

var (
	// OutputTypes - All Supported Output Types
	OutputTypes = map[string]string{
		JSON.ToOutput(): JSON.ToOutput(),
		Table:           Table,
	}
)

// ToOutput - returns the output type as string
func (c Output) ToOutput() string {
	return string(c)
}
