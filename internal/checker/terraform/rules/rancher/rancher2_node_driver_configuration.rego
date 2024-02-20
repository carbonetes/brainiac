# METADATA
# title: "Verify Rancher2 Node Driver Configuration"
# description: "Policy to verify Rancher2 Node Driver Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_driver
# custom:
#   id: CB_TFRAN_088
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_088

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_driver" in block.Labels
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
	block.Attributes.active == true
	is_boolean(block.Attributes.builtin)
	block.Attributes.name != ""
	block.Attributes.url != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation of Rancher2 Node Driver Configuration, ensuring compliance with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Node Driver Configuration. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}
