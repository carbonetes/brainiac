# METADATA
# title: "Verify that Storage logging is activated including read, write, and delete requests for the Queue service"
# description: "This check confirms that Storage logging is configured to capture activity within the Queue service, specifically for read, write, and delete requests. Activating this logging provides valuable insights into Queue service operations for monitoring and auditing purposes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_027
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_027

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_storage_account" in block.Labels
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
    isvalid(resource)
    supportedKind := ["Storage", "StorageV2"]
    resource.Attributes.account_kind in supportedKind
    some block in resource.Blocks
    block.Type == "queue_properties"
    some innerBlock in block.Blocks
    innerBlock.Type == "logging"
    innerBlock.Attributes.read != true
    innerBlock.Attributes.write != true
    innerBlock.Attributes.delete != true
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The Storage logging is activated including read, write, and delete requests for the Queue service.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The Storage logging must be activated including read, write, and delete requests for the Queue service.",
                "snippet": block }
} 