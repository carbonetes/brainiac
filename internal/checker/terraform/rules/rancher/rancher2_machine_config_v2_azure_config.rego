# METADATA
# title: "Verify Azure Configuration for Machine Config V2"
# description: Policy to ensure the compatibility of Azure Configuration for Machine Config V2 and prevent conflicts with other cloud provider configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/machine_config_v2
# custom:
#   id: CB_TFRAN_134
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_134

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_machine_config_v2" in block.Labels
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
	azure_config(block)
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type != "azure_config"
}

azure_config(block) {
	conflict_configs := [
		"amazonec2_config",
		"digitalocean_config",
		"harvester_config",
		"linode_config",
		"openstack_config",
		"vsphere_config",
	]
	some innerblock in block.Blocks
	innerblock.Type == "azure_config"
	innerblock.Type in conflict_configs
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Configuration for Machine Config V2 has been successfully validated, ensuring compatibility and preventing conflicts with other cloud provider configurations",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Azure Configuration for Machine Config V2. Please ensure compatibility and avoid conflicts with other cloud provider configurations.",
		"snippet": block,
	}
}
