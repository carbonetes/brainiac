# METADATA
# title: "Disable Public Network Access for Azure Key Vault"
# description: "This policy ensures that public network access is disabled for Azure Key Vault, enhancing security by restricting access to trusted networks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
# custom:
#   id: CB_TFAZR_184
#   severity: HIGH
package lib.terraform.CB_TFAZR_184

import future.keywords.if
import future.keywords.in

supportedResources := ["azurerm_key_vault"]

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	isPublicNetEnabled(resource)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

isPublicNetEnabled(resource) if {
	some block in resource.Blocks
	resource.Attributes.public_network_access_enabled == true
	block.Type == "network_acls"
	count(block.Attributes.ip_rules) > 0
} else if {
	resource.Attributes.public_network_access_enabled == false
}

passed[result] {
	some block in pass
	result := {"message": "Azure Key Vault has public network access disabled, enhancing security."}
}

failed[result] {
	some block in fail
	result := {"message": "Azure Key Vault should have public network access disabled to enhance security by restricting access to trusted networks."}
}
