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
	block.Attributes.public_network_access_enabled == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'Public Network Access Enabled' setting is properly configured and set to 'False' for MariaDB servers.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'Public Network Access Enabled' setting is not properly configured or set to 'False' for MariaDB servers.",
		"snippet": block,
	}
}
