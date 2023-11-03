# METADATA
# title: "Verify Azure SQL Database Has Transparent Data Encryption (TDE) Enabled"
# description: "This policy ensures that Transparent Data Encryption (TDE) is enabled for Azure SQL Databases, enhancing data security by encrypting the database files."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database
# custom:
#   id: CB_TFAZR_222
#   severity: HIGH
package lib.terraform.CB_TFAZR_222

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_mssql_database" in resource.Labels
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
	resource.Attributes.transparent_data_encryption_enabled != false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Transparent Data Encryption (TDE) is enabled for Azure SQL Database.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Transparent Data Encryption (TDE) is not enabled for Azure SQL Database.",
		"snippet": block,
	}
}
