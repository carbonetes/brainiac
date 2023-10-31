# METADATA
# title: "Verify that My SQL server enables geo-redundant backups"
# description: "It provides a failover option, maintains data integrity, meets compliance requirements, and ensures data availability across geographic locations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_flexible_server
# custom:
#   id: CB_TFAZR_073
#   severity: LOW
package lib.terraform.CB_TFAZR_073

import future.keywords.in

supported_resources := ["azurerm_mysql_flexible_server", "azurerm_mysql_server"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.geo_redundant_backup_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "My SQL server enables geo-redundant backups.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "My SQL server is ideal to enabled geo-redundant backups.",
		"snippet": block,
	}
}
