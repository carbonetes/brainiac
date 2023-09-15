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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_storage_account"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "queue_properties"
    resource.Blocks[_].Blocks[_].Type == "logging"
    resource.Blocks[_].Blocks[_].Attributes.read == true
    resource.Blocks[_].Blocks[_].Attributes.write == true
    resource.Blocks[_].Blocks[_].Attributes.delete == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
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