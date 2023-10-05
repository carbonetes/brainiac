# METADATA
# title: "Verify PostgreSQL is using the latest version of TLS encryption"
# description: "This policy is designed to enhance the security of PostgreSQL databases by verifying that they are using the latest version of TLS (Transport Layer Security) encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_server
# custom:
#   id: CB_TFAZR_132
#   severity: LOW
package lib.terraform.CB_TFAZR_132

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.ssl_minimal_tls_version_enforced == "TLS1_2"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "PostgreSQL is using the latest version of TLS encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "PostgreSQL is not using the latest version of TLS encryption.",
		"snippet": block,
	}
}