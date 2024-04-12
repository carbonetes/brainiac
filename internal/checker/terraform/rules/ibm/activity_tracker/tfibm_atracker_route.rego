# METADATA
# title: "Verify the route to prevent misrouting and data leakage"
# description: "This policy verifies that the 'name' attribute of the 'ibm_atracker_route' resource adheres to the specified constraints to prevent misrouting and data leakage. This is crucial for maintaining data security and system visibility."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/atracker_route
# custom:
#   id: CB_TFIBM_013
#   severity: LOW
package lib.terraform.CB_TFIBM_013

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_atracker_route" in block.Labels
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
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasInvalidAttribute(resource)
}

hasInvalidAttribute(block) if {
	not regex.match(`^[a-zA-Z0-9 -._:]+$`, block.Attributes.name)
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM Activity Tracker Route adheres to the specified constraints, preventing potential misrouting and data leakage.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM Activity Tracker Route must adhere to the specified constraints to prevent potential misrouting and data leakage.",
		"snippet": block,
	}
}
