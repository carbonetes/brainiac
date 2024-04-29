# METADATA
# title: "Verify environment variables name are properly configured"
# description: "This policy establishes criteria to ensure that environment variables name are compliant with maximum length limitations and utilize permissible characters exclusively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_090
#   severity: LOW
package lib.terraform.CB_TFIBM_090
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
	res.Type == "run_env_variables"
	attributes := res.Attributes
    "name" in object.keys(attributes)
	pattern := "^[\\-._a-zA-Z0-9]+$"
	not regex.match(pattern, attributes["name"])
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    attributes.name == ""
    count(attributes.name) > 253
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Environment variable name is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Environment variable name is not properly set.",
		"snippet": block,
	}
}
