# METADATA
# title: "Verify authentication token is not exposed"
# description: "This policy verifies that the authentication token is not exposed within the system. Ensuring the confidentiality of authentication tokens is crucial for preventing security breaches and unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_version
# custom:
#   id: CB_TFIBM_037
#   severity: HIGH
package lib.terraform.CB_TFIBM_037

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_cm_version", "cm_version"]
	label in supported_resource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	attribute := resource.Attributes
    attribute.x_auth_token == ""
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Authentication token is not exposed",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Authentication token is exposed",
		"snippet": block,
	}
}