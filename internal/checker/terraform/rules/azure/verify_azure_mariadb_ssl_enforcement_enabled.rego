# METADATA
# title: "Verify 'Enforce SSL connection' is set to 'ENABLED' for MariaDB servers"
# description: "This policy is designed to enhance the security of MariaDB servers by verifying that the 'Enforce SSL Connection' setting is properly configured and set to 'ENABLED'."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server
# custom:
#   id: CB_TFAZR_015
#   severity: HIGH
package lib.terraform.CB_TFAZR_015

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mariadb_server" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.ssl_enforcement_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'Enforce SSL Connection' setting is properly configured and set to 'ENABLED' for MariaDB servers.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'Enforce SSL Connection' setting is not properly configured or set to 'ENABLED' for MariaDB servers.",
		"snippet": block,
	}
}
