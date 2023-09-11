# METADATA
# title: "Verify 'Enforce SSL connection' is set to 'ENABLED' for MariaDB servers"
# description: "This policy is designed to enhance the security of MariaDB servers by verifying that the 'Enforce SSL Connection' setting is properly configured and set to 'ENABLED'."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server
# custom:
#   id: CB_TFAZR_014
#   severity: HIGH
package lib.terraform.CB_TFAZR_015

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "azurerm_mariadb_server"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.ssl_enforcement_enabled == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The 'Enforce SSL Connection' setting is properly configured and set to 'ENABLED' for MariaDB servers.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The 'Enforce SSL Connection' setting is not properly configured or set to 'ENABLED' for MariaDB servers.",
		"snippet": block,
	}
}
