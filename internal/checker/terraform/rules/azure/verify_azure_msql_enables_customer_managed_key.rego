# METADATA
# title: "Verify that MySQL server enables customer-managed key for encryption"
# description: "This policy is designed to enhance the security and data protection of MySQL servers by verifying that customer-managed keys are enabled for encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_server
# custom:
#   id: CB_TFAZR_231
#   severity: LOW
package lib.terraform.CB_TFAZR_231

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mysql_server" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_mysql_server[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_mysql_server" in resource.Labels
	label := concat(".", resource.Labels)
}

label_for_key_vault_key[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_key_vault_key" in resource.Labels
	label := concat(".", resource.Labels)
}

is_mysql_server_attached {
	some block in input
	block.Type == "resource"
	"azurerm_mysql_server_key" in block.Labels
	some label in label_for_mysql_server
	contains(block.Attributes.server_id, label)
}

is_mysql_server_key_attached {
	some block in input
	block.Type == "resource"
	"azurerm_mysql_server_key" in block.Labels
	some label in label_for_key_vault_key
	contains(block.Attributes.key_vault_key_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	is_mysql_server_attached
	is_mysql_server_key_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "MySQL server is configured to use customer-managed keys for encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "MySQL server does not use customer-managed keys for encryption.",
		"snippet": block,
	}
}