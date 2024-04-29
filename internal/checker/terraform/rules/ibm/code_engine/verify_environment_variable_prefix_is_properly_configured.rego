# METADATA
# title: "Verify environment variables prefix are properly configured"
# description: "This policy establishes criteria to ensure that environment variables prefix are compliant with maximum length limitations and utilize permissible characters exclusively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_091
#   severity: LOW
package lib.terraform.CB_TFIBM_091
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_app"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    "prefix" in object.keys(attributes)
	pattern := "^[a-zA-Z_][a-zA-Z0-9_]*$"
	not regex.match(pattern, attributes["prefix"])
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    count(attributes.prefix) > 253
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Environment variable prefix is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Environment variable prefix is not properly set.",
		"snippet": block,
	}
}
