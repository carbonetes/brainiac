# METADATA
# title: "Verify Linode Configuration for Node Template"
# description: "This policy ensures that Rancher2 Node Template using the Linode driver are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_template
# custom:
#   id: CB_TFRAN_151
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_151

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_template" in block.Labels
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
	not validate_linode(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

validate_linode(block) {
	some innerblock in block.Blocks
	innerblock.Type == "linode_config"
	innerblock.Attributes.token != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Linode Configuration for Rancher2 Node Template is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Linode Configuration for Rancher2 Node Template has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
