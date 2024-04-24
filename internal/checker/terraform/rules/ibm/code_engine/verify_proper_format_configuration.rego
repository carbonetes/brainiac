# METADATA
# title: "Verify proper format configuration"
# description: "This policy validates that the specified format for the secret adheres to the allowed values and regular expression constraints."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/code_engine_secret
# custom:
#   id: CB_TFIBM_071
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_071
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
    label == "ibm_code_engine_secret"
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
    not pass[block]
}

pass contains resource if {
	some resource in input
	isvalid(resource)
    supported_values := ["generic", "ssh_auth","basic_auth","tls","service_access","registry"]
    block := resource.Attributes
    "format" in object.keys(block)
    format := block.format
    format in supported_values
}

passed contains result if {
	some block in pass
	result := {
		"message": "Format Configuration is properly configured.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Format Configuration is not properly configured.",
		"snippet": block,
	}
}
