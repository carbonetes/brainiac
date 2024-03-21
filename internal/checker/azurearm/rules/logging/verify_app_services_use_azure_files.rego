# METADATA
# title: "Verify app services are configured to use Azure Files"
# description: "Verification is necessary to confirm that app services within the Azure environment are properly configured to leverage Azure Files storage, enhancing file storage capabilities and facilitating seamless data management within the infrastructure."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_052
#   severity: LOW
package lib.azurearm.CB_AZR_052
import future.keywords.in

resource := "Microsoft.Web/sites/config"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties.azureStorageAccounts
	properties.type == "AzureFiles"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "App service use Azure files",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "App service do not use Azure files",
		"snippet": block,
	}
}