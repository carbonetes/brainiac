# METADATA
# title: "Verify that MySQL server enables infrastructure encryption"
# description: "It ensures compliance, protects against breaches, and safeguards sensitive information from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mysql_server
# custom:
#   id: CB_TFAZR_078
#   severity: LOW
package lib.terraform.CB_TFAZR_078

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mysql_server" in block.Labels
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

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "'azurerm_mysql_server' infrastructure_encryption_enabled is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'azurerm_mysql_server' infrastructure_encryption_enabled should be set to true.",
		"snippet": block,
	}
}
