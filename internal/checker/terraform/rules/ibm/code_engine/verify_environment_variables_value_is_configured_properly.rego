# METADATA
# title: "Verify environment variables value are properly configured"
# description: "This policy establishes criteria to ensure that environment variables value are compliant with maximum length limitations and utilize permissible characters exclusively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_094
#   severity: LOW
package lib.terraform.CB_TFIBM_094
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
    "value" in object.keys(attributes)
	pattern := "^[\\-._a-zA-Z0-9]+$"
	not regex.match(pattern, attributes["value"])
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    count(attributes.value) > 253
    attributes.value == ""
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Environment variable value is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Environment variable value is not properly set.",
		"snippet": block,
	}
}
