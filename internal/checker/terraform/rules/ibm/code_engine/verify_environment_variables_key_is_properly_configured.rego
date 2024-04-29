# METADATA
# title: "Verify environment variables key are properly configured"
# description: "This policy establishes criteria to ensure that environment variables key are compliant with maximum length limitations and utilize permissible characters exclusively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_083
#   severity: LOW
package lib.terraform.CB_TFIBM_083
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
    "key" in object.keys(attributes)
	pattern := "^[\\-._a-zA-Z0-9]+$"
	not regex.match(pattern, attributes["key"])
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    attributes.key == ""
    count(attributes.key) > 253
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Environment variable key is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Environment variable key is not properly set.",
		"snippet": block,
	}
}
