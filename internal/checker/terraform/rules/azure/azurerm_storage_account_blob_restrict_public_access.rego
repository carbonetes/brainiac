# METADATA
# title: "Restrict Public Access to Storage Blobs"
# description: "This policy verifies that public access to storage blobs is restricted, enhancing security by preventing unauthorized access to sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_186
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_186

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

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.allow_nested_items_to_be_public != true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage blobs restrict public access, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage blobs should restrict public access to prevent unauthorized access and enhance security.",
		"snippet": block, 
    }
}
