# METADATA
# title: "Confirm that Azure Synapse workspaces allows for the utilization of managed virtual networks"
# description: "Verify that Azure Synapse workspaces offer support for managed virtual networks, granting users the ability to efficiently oversee and customize their network setups. This feature enhances network management and ensures a secure and tailored environment for your workspace needs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace
# custom:
#   id: CB_TFAZR_053
#   severity: LOW
package lib.terraform.CB_TFAZR_053

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_synapse_workspace" in block.Labels
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
	block.Attributes.managed_virtual_network_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Synapse workspaces supports the use of managed virtual networks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Synapse workspaces should support the use of managed virtual networks.",
		"snippet": block,
	}
}