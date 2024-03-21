# METADATA
# title: "Verify Azure SQL Azure AD authentication is enabled"
# description: "This policy ensures that the Azure SQL has Azure Active Directory authentication enabled to ensure secure access control through centralized identity management."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_080
#   severity: MEDIUM
package lib.azurearm.CB_AZR_080
import future.keywords.in

resource := "Microsoft.Sql/servers"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
  	properties := resource.properties
    properties.administratorLogin != ""
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure SQL server has Azure Active Directory Authentication enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure SQL server has Azure Active Directory Authentication disabled",
		"snippet": block,
	}
}
