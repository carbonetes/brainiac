# METADATA
# title: "Verify user password is secured"
# description: "This policy ensures robust protection of sensitive information by enforcing security measures for passwords. It verifies that passwords adhere to specific requirements, including minimum length, complexity, and absence of hardcoded passwords."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/compute_user
# custom:
#   id: CB_TFIBM_048
#   severity: HIGH
package lib.terraform.CB_TFIBM_048

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

pass contains resource if {
	some resource in input
	isvalid(resource)
	pass := resource.Attributes.password
	count(pass) >= 8
	count(pass) <= 20
	regex.match(`[A-Z]+`, pass)
	regex.match(`[a-z]+`, pass)
	regex.match(`[0-9]+`, pass)
	regex.match(`[_\-|@.,?/!~#$%^&*(){}\[\]=]+`, pass)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "User password is secure",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "User password is not secure",
		"snippet": block,
	}
}