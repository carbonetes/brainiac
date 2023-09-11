# METADATA
# title: "Confirm that the default network access rule for Storage Accounts is configured to deny access"
# description: "Please validate that the default network access rule for Storage Accounts is configured to block access. This measure is essential for enhancing the security of your storage resources by denying any unauthorized network traffic by default, ensuring data protection and system integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_011
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_011

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "network_rules"
    resource.Blocks[_].Attributes.default_action == "Deny"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The default network access rule for Storage Accounts is configured to deny access.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The default network access rule for Storage Accounts must be configured to deny access.",
                "snippet": block }
} 