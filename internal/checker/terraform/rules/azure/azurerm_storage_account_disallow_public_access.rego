# METADATA
# title: "Make certain that storage accounts prohibit public access, confirming that unauthorized access to storage resources is restricted"
# description: "Implement robust security measures by configuring storage accounts to prevent public access. This precautionary step helps safeguard sensitive data and resources, confirming that only authorized users can interact with the storage infrastructure, thereby enhancing data privacy and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_057
#   severity: LOW
package lib.terraform.CB_TFAZR_057

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
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
	block.Attributes.public_network_access_enabled == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Public access is restricted by storage accounts.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage accounts must restrict public access.",
		"snippet": block,
	}
}