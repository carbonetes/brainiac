# METADATA
# title: "Verify Rancher2 Global Role Configuration"
# description: "Policy to verify Rancher2 Global Role Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_role
# custom:
#   id: CB_TFRAN_083
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_083

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global Role configurations are valid and comply with specified standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Global Role configurations are invalid. Please review and update configurations to ensure compliance with specified standards.",
		"snippet": block,
	}
}
