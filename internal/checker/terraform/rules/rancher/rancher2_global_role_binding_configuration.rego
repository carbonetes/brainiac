# METADATA
# title: "Verify Rancher2 Global Role Binding Configuration"
# description: "Policy for validating Rancher2 Global Role Binding Configuration, ensuring conformity with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_role_binding
# custom:
#   id: CB_TFRAN_084
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_084

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_role_binding" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.global_role_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global Role Binding configurations meet the specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Global Role Binding configurations are incomplete. Please ensure all required fields are provided for proper configuration.",
		"snippet": block,
	}
}
