# METADATA
# title: "Administers a rule in a firewall that controls access to a MariaDB Server."
# description: "This involves overseeing a specific rule within a firewall to regulate and control access to a MariaDB Server"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mariadb_firewall_rule
# custom:
#   id: CB_TFAZR_031
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_031

supportedResource := [
	"azurerm_mariadb_firewall_rule",
	"azurerm_sql_firewall_rule",
	"azurerm_postgresql_firewall_rule",
	"azurerm_mysql_firewall_rule",
]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResource[_]
}

pass[resource] {
	resource := input[_]
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	resource := input[_]
	isvalid(resource)
	invalidStartAddress := ["0.0.0.0", "0.0.0.0/0"]
	resource.Attributes.start_ip_address == invalidStartAddress[_]
	resource.Attributes.end_ip_address == "255.255.255.255"
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The firewall rule is correctly configured and secure.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The firewall rule configuration is not secure.",
		"snippet": block,
	}
}
