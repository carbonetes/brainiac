# METADATA
# title: "Verify that PostgreSQL server enables customer-managed key for encryption"
# description: "This policy is designed to enhance the security and data protection of PostgreSQL servers by verifying that customer-managed keys are enabled for encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server_key
# custom:
#   id: CB_TFAZR_235
#   severity: LOW
package lib.terraform.CB_TFAZR_235

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_postgresql_server_key" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_postgresql_server[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_postgresql_server" in resource.Labels
	label := concat(".", resource.Labels)
}

label_for_key_vault_key[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_key_vault_key" in resource.Labels
	label := concat(".", resource.Labels)
}

is_postgresql_server_attached {
	some block in input
	block.Type == "resource"
	"azurerm_postgresql_server_key" in block.Labels
	some label in label_for_postgresql_server
	contains(block.Attributes.server_id, label)
}

is_key_vault_key_attached {
	some block in input
	block.Type == "resource"
	"azurerm_postgresql_server_key" in block.Labels
	some label in label_for_key_vault_key
	contains(block.Attributes.key_vault_key_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	is_postgresql_server_attached
	is_key_vault_key_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "PostgreSQL server enables customer-managed key for encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "PostgreSQL server does not enable customer-managed key for encryption.",
		"snippet": block,
	}
}