# METADATA
# title: "Verify access to Storage Accounts is enabled for 'Trusted Microsoft Services'"
# description: "This policy allows certain Microsoft services to bypass network rules when accessing storage accounts. These services operate from networks that cannot be granted access through typical network rules. By enabling this feature, trusted Microsoft services, such as Azure Backup, Azure Site Recovery, Azure DevTest Labs, Azure Event Grid, Azure Event Hubs, Azure Networking, Azure Monitor, and Azure SQL Data Warehouse (when registered in the subscription), can access the storage account using strong authentication methods."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_036
#   severity: MEDIUM
package lib.azurearm.CB_AZR_036

import future.keywords.in

resource := "Microsoft.Storage/storageAccounts"

is_valid {
	some resources in input.resources
	resources.type == resource
}

fail[properties] {
	some resource in input.resources
	properties := resource.apiVersion
	year := substring(properties, 0, 4)
	to_number(year) < 2017
}

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.networkAcls
	properties.defaultAction != "Allow"
}

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.networkAcls
	properties.bypass != "AzureServices"
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Trusted Microsoft Services is enabled for Storage Account access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Trusted Microsoft Services is not enabled for Storage Account access.",
		"snippet": block,
	}
}
