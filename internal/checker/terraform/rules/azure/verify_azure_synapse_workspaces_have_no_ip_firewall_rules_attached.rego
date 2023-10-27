# METADATA
# title: "Verify that Azure Synapse workspaces have no IP firewall rules attached"
# description: "This policy is designed to enhance the security and network access control of Azure Synapse workspaces by verifying that no IP firewall rules are attached."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace
# custom:
#   id: CB_TFAZR_236
#   severity: LOW
package lib.terraform.CB_TFAZR_236

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

label_for_synapse_workspace[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_synapse_workspace" in resource.Labels
	label := concat(".", resource.Labels)
}

is_synapse_workspace_not_attached {
	some block in input
	block.Type == "resource"
	"azurerm_synapse_firewall_rule" in block.Labels
	some label in label_for_synapse_workspace
	not contains(block.Attributes.synapse_workspace_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	is_synapse_workspace_not_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Synapse workspace has no IP firewall rules attached.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Synapse workspace has IP firewall rules attached.",
		"snippet": block,
	}
}