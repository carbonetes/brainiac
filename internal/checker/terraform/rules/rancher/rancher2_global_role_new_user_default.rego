# METADATA
# title: "Verify Rancher 2 Global Role Configuration for New User Default"
# description: "Policy to verify Rancher2 Global Role Configuration for New User Default, specifying whether this role should be added to new users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_role
# custom:
#   id: CB_TFRAN_130
#   severity: LOW
package lib.terraform.CB_TFRAN_130

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_role" in block.Labels
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
	is_boolean(block.Attributes.new_user_default) != false
	block.Attributes.new_user_default == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Global Role Configuration for New User Default successfully validated. The role is set to the specified default, indicating whether it should be added to new users.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Global Role Configuration for New User Default. Ensure that 'new_user_default' is included and specified as a boolean value, indicating whether the role should be added to new users.",
		"snippet": block,
	}
}
