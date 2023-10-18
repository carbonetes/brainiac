# METADATA
# title: "Secure important data storage using a Customer Managed Key"
# description: "Make certain that sensitive data storage is protected through the use of a Customer Managed Key."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# custom:
#   id: CB_TFAZR_202
#   severity: HIGH
package lib.terraform.CB_TFAZR_202

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_storage_account_customer_managed_key" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}


getLabelForStorageAcc[label]{
	some block in input
    block.Type == "resource"
    block.Labels[_] == "azurerm_storage_account"
    label := concat(".", block.Labels)
}

storageIsAttached{
    some block in input
    block.Type == "resource"
    "azurerm_storage_account_customer_managed_key" in block.Labels
    contains(block.Attributes.storage_account_id, getLabelForStorageAcc[label])
}

pass[block]{
    some block in input
	isvalid(block)
    storageIsAttached
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { "message": "Important data storage is secured using a Customer Managed Key.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Important data storage must be secured using a Customer Managed Key.",
                "snippet": block }
} 