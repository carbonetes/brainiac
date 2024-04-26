# METADATA
# title: "Verify user has api key enabled"
# description: "This policy ensures robust protection of sensitive information by enforcing security measures for passwords. It verifies that passwords adhere to specific requirements, including minimum length, complexity, and absence of hardcoded passwords."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_user
# custom:
#   id: CB_TFIBM_049
#   severity: HIGH
package lib.terraform.CB_TFIBM_049

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resource := ["ibm_compute_user", "joe"]
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
	api := resource.Attributes.has_api_key
    api == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "User has api key enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "User has api key not enabled",
		"snippet": block,
	}
}