# METADATA
# title: "Secure important data storage using a Customer Managed Key"
# description: "Make certain that sensitive data storage is protected through the use of a Customer Managed Key."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key
# custom:
#   id: CB_TFAZR_241
#   severity: LOW
package lib.terraform.CB_TFAZR_241

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_sql_firewall_rule" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_sql_server[label] {
	some block in input
	block.Type == "resource"
	"azurerm_sql_server" in block.Labels
	label := concat(".", block.Labels)
}

sql_server_is_attached {
	some block in input
	block.Type == "resource"
	"azurerm_sql_firewall_rule" in block.Labels
	some label in label_for_sql_server
	contains(block.Attributes.storage_account_id, label)
}

pass[block]{
    some block in input
	isvalid(block)
    block.Attributes.start_ip_address != "0.0.0.0"
    block.Attributes.end_ip_address   != "0.0.0.0"
	sql_server_is_attached
}

pass[block]{
    some block in input
	isvalid(block)
    block.Attributes.start_ip_address != "0.0.0.0"
    block.Attributes.end_ip_address   != "0.0.0.0"
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
		"message": "Important data storage is secured using a Customer Managed Key.",
        "snippet": block, 
	}
}

failed[result] {
    some block in fail
	result := { 
		"message": "Important data storage must be secured using a Customer Managed Key.",
        "snippet": block, 
	}
} 