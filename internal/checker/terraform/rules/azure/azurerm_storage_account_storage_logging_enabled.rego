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
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource]{
    some resource in input
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
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Storage logging is activated including read, write, and delete requests for the Queue service.",
        "snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := { 
        "message": "The Storage logging must be activated including read, write, and delete requests for the Queue service.",
        "snippet": block, 
    }
} 