# METADATA
# title: "Verify Rancher2 Node Pool Configuration with Node Taints"
# description: "Policy to ensure Rancher2 Node Pool Configuration includes appropriate Node Taints."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/4.0.0/docs/resources/node_pool
# custom:
#   id: CB_TFRAN_110
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_110

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_pool" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "node_taints"
	innerblock.Attributes.key != ""
	innerblock.Attributes.value != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Pool Configuration, including Node Taints, successfully verified for compliance.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Node Pool Configuration regarding Node Taints. Review and adjust settings to ensure compliance.",
		"snippet": block,
	}
}
