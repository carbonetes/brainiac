# METADATA
# title: "Verify App Service has Register with Azure Active Directory feature enabled"
# description: "This policy ensures the security benefits of utilizing Managed Service Identity (MSI) in App Service, which enhances security by removing the need for storing sensitive credentials, such as connection strings, within the application."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_016
#   severity: MEDIUM
package lib.azurearm.CB_AZR_016

import future.keywords.in

resource := "Microsoft.Web/sites"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	identity := properties.identity
	identity.type == "SystemAssigned"
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	identity := properties.identity
	identity.type == "UserAssigned"
	count(identity.userAssignedIdentities) > 0
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Web App is configured to use Managed Service Identity (MSI) in Azure App Service.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Web App is not configured to use Managed Service Identity (MSI) in Azure App Service.",
		"snippet": block,
	}
}
