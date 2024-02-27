# METADATA
# title: "Verify Rancher2 Node Pool Roles for Created Nodes"
# description: "Policy to verify Rancher2 Node Pool Roles for Created Nodes, requiring specified roles to be provided as boolean values."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_pool
# custom:
#   id: CB_TFRAN_146
#   severity: LOW
package lib.terraform.CB_TFRAN_146

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
	not is_boolean(block.Attributes.control_plane)
}

fail[block] {
	some block in input
	isvalid(block)
	not is_boolean(block.Attributes.etcd)
}

fail[block] {
	some block in input
	isvalid(block)
	not is_boolean(block.Attributes.worker)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Pool Roles for Created Nodes successfully validated with boolean values.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Node Pool Roles for Created Nodes. Ensure that boolean values are provided for specified roles.",
		"snippet": block,
	}
}
