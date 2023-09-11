# METADATA
# title: "Verify 'public network access enabled' is set to 'False' for MariaDB servers"
# description: "This policy is designed to enhance the security of MariaDB servers by verifying that the 'Public Network Access Enabled' setting is properly configured and set to 'False'."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_server
# custom:
#   id: CB_TFAZR_016
#   severity: HIGH
package lib.terraform.CB_TFAZR_016

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
	block.Attributes.public_network_access_enabled == false
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The 'Public Network Access Enabled' setting is properly configured and set to 'False' for MariaDB servers.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The 'Public Network Access Enabled' setting is not properly configured or set to 'False' for MariaDB servers.",
		"snippet": block,
	}
}
