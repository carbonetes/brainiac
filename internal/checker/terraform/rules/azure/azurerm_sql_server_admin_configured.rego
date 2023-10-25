# METADATA
# title: "Verify the setup of Azure Active Directory Admin"
# description: "Verify the proper setup of Azure Active Directory Admin to assure security compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/sql_active_directory_administrator
# custom:
#   id: CB_TFAZR_217
#   severity: LOW
package lib.terraform.CB_TFAZR_217

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_sql_active_directory_administrator" in block.Labels
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
	some label in label_for_sql_server
	contains(block.Attributes.server_name, label)
}

pass[block] {
	some block in input
	isvalid(block)
	sql_server_is_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Azure Active Directory Admin has been correctly established.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure Active Directory Admin is not established.",
		"snippet": block,
	}
}
