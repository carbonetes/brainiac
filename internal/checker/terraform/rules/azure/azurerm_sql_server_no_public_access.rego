# METADATA
# title: "Administers a rule in a firewall that controls access to a MariaDB Server"
# description: "This involves overseeing a specific rule within a firewall to regulate and control access to a MariaDB Server"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_firewall_rule
# custom:
#   id: CB_TFAZR_031
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_031

import future.keywords.in

supported_resources := [
	"azurerm_mariadb_firewall_rule",
	"azurerm_sql_firewall_rule",
	"azurerm_postgresql_firewall_rule",
	"azurerm_mysql_firewall_rule",
]

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
	not fail[resource]
}

fail[resource] {
    some resource in input
	isvalid(resource)
	invalid_start_address := ["0.0.0.0", "0.0.0.0/0"]
	resource.Attributes.start_ip_address in invalid_start_address
	resource.Attributes.end_ip_address == "255.255.255.255"
}

passed[result] {
	some block in pass
	result := {
		"message": "The firewall rule is correctly configured and secure.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The firewall rule configuration is not secure.",
		"snippet": block,
	}
}