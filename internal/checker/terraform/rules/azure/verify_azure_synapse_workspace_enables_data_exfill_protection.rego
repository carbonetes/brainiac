# METADATA
# title: "Verify that Synapse workspace has data_exfiltration_protection_enabled"
# description: "This policy is designed to enhance the security of Azure Synapse workspaces by verifying that data exfiltration protection is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/synapse_workspace
# custom:
#   id: CB_TFAZR_171
#   severity: LOW
package lib.terraform.CB_TFAZR_171

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
	block.Attributes.data_exfiltration_protection_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Synapse workspace has data exfiltration protection enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Synapse workspace does not have data exfiltration protection enabled.",
		"snippet": block,
	}
}