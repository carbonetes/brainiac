# METADATA
# title: "Verify environment variables reference are properly configured"
# description: "This policy establishes criteria to ensure that environment variables reference are compliant with maximum length limitations and utilize permissible characters exclusively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_app
# custom:
#   id: CB_TFIBM_092
#   severity: LOW
package lib.terraform.CB_TFIBM_092
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
    "reference" in object.keys(attributes)
	pattern := "^[a-z0-9]([\\-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([\\-a-z0-9]*[a-z0-9])?)*$"
	not regex.match(pattern, attributes["reference"])
}

fail contains block if {
	some block in input
	isvalid(block)
	some res in block.Blocks
	attributes := res.Attributes
    count(attributes.reference) > 253
    attributes.reference == ""
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    not fail[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Environment variable reference is properly set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Environment variable reference is not properly set.",
		"snippet": block,
	}
}
