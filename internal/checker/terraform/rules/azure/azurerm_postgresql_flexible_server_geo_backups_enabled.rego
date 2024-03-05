# METADATA
# title: "Confirm that geo-redundant backups are activated for the PostgreSQL Flexible server"
# description: "Verify that the PostgreSQL Flexible server is configured to support geo-redundant backups for enhanced data protection."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server
# custom:
#   id: CB_TFAZR_168
#   severity: LOW
package lib.terraform.CB_TFAZR_168

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_postgresql_flexible_server" in block.Labels
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

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The geo-redundant backups are activated for the PostgreSQL Flexible server.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The geo-redundant backups must be activated for the PostgreSQL Flexible server.",
		"snippet": block,
	}
}
