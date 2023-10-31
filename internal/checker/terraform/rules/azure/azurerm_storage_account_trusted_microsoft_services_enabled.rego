# METADATA
# title: "Confirm that 'Trusted Microsoft Services' is active for interaction with the Storage Account"
# description: "Verify that the 'Trusted Microsoft Services' feature is activated within the Storage Account settings. This confirms that authorized Microsoft services can securely access the Storage Account for various operations, enhancing the account's functionality and security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_028
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_028

supportedResources := ["azurerm_storage_account", "azurerm_storage_account_network_rules"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
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
    resource.Blocks[_].Type == "network_rules"
    resource.Blocks[_].Attributes.default_action == "Deny"
    resource.Blocks[_].Attributes.bypass[_] != "AzureServices"
  
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The 'Trusted Microsoft Services' is active for interaction with the Storage Account.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The 'Trusted Microsoft Services' must be active for interaction with the Storage Account.",
                "snippet": block }
} 