# METADATA
# title: "Verify that Key Vault permits firewall rules configuration"
# description: "Check that Key Vault allows configuration of firewall rules, enabling control over network access to the vault for enhanced security"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# custom:
#   id: CB_TFAZR_107
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_107

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_key_vault" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some innerblock in resource.Blocks
	innerblock.Type == "network_acls"
	innerblock.Attributes.default_action == "Deny"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Key Vault allows firewall rules configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key Vault does not permit firewall rules configuration as required.",
		"snippet": block,
	}
}
