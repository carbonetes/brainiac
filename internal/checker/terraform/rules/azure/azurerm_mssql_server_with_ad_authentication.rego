# METADATA
# title: "Verify Azure SQL (MSSQL) Enables Azure AD Authentication"
# description: "This policy checks whether Azure SQL (MSSQL) instances have Azure AD authentication enabled. Enabling Azure AD authentication enhances security and provides more secure access control."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# custom:
#   id: CB_TFAZR_225
#   severity: HIGH
package lib.terraform.CB_TFAZR_225

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_mssql_server" in resource.Labels
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
	some block in resource.Blocks
	block.Type == "azuread_administrator"
	count(block.Attributes.login_username) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure SQL (MSSQL) has Azure AD authentication enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure SQL (MSSQL) does not have Azure AD authentication enabled.",
		"snippet": block,
	}
}