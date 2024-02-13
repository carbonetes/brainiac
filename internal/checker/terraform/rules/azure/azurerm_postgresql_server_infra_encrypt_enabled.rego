# METADATA
# title: "Verify that infrastructure encryption is activated on the PostgreSQL server"
# description: "Confirm that infrastructure encryption is active on the PostgreSQL server, providing an additional layer of security by safeguarding sensitive data and system resources. This encryption measure enhances the protection of critical infrastructure components within your PostgreSQL environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_120
#   severity: LOW
package lib.terraform.CB_TFAZR_120

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_postgresql_server" in block.Labels
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
	resource.Attributes.infrastructure_encryption_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The infrastructure encryption is activated on the PostgreSQL server.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The infrastructure encryption is not activated on the PostgreSQL server.",
		"snippet": block,
	}
}
