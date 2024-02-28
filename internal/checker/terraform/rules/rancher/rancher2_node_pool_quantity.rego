# METADATA
# title: "Verify Rancher2 Node Pool Non-Zero Quantity"
# description: "Policy to ensure that Rancher2 Node Pool configuration specifies non-zero quantity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_pool
# custom:
#   id: CB_TFRAN_145
#   severity: LOW
package lib.terraform.CB_TFRAN_145

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

fail[block] {
	some block in input
	isvalid(block)
	is_number(block.Attributes.quantity) != false
    to_number(block.Attributes.quantity) <= 0
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Pool has valid quantity.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Node Pool configuration have invalid quantity. Please ensure that quantity are set to non-zero values.",
		"snippet": block,
	}
}
