# METADATA
# title: "Verify Rancher2 User Name"
# description: "Policy to verify Rancher2 User Name, ensuring that the 'name' field is provided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/user
# custom:
#   id: CB_TFRAN_187
#   severity: LOW
package lib.terraform.CB_TFRAN_187

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_user" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.name == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 User Name has been successfully validated with the 'name' field specified.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 User Name configuration. Ensure that the 'name' field is provided and specifies the user's full name.",
		"snippet": block,
	}
}
