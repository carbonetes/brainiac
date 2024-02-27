# METADATA
# title: "Verify Supported Drivers in Rancher2 Node Template"
# description: "This policy ensures that the Rancher2 Node Template uses a supported driver."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_template
# custom:
#   id: CB_TFRAN_147
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_147

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
	drivers := [
		"amazonec2_config",
		"azure_config",
		"digitalocean_config",
		"linode_config",
		"harvester_config",
		"hetzner_config",
		"opennebula_config",
		"openstack_config",
		"outscale_config",
		"vsphere_config",
	]
	some innerblock in block.Blocks
	not innerblock.Type in drivers
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Template uses a supported driver.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Ensure the Rancher2 Node Template uses a supported driver.",
		"snippet": block,
	}
}
