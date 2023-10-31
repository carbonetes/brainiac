# METADATA
# title: "Verify Azure PostgreSQL Flexible Server Has Secure Network Access Configuration"
# description: "This policy aims to validate that Azure PostgreSQL Flexible Servers are not configured with excessively permissive network access settings. It's crucial to ensure that the network access configuration follows security best practices to minimize potential security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule
# custom:
#   id: CB_TFAZR_224
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_224

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_postgresql_flexible_server_firewall_rule" in resource.Labels
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
	resource.Attributes.start_ip_address != "0.0.0.0"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.end_ip_address != "255.255.255.255"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure PostgreSQL Flexible Server has a secure network access configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure PostgreSQL Flexible Server is configured with overly permissive network access settings.",
		"snippet": block,
	}
}
