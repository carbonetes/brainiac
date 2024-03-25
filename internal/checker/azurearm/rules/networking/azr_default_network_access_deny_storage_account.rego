# METADATA
# title: "Verify Storage Accounts default network access rule is configured to deny"
# description: "This policy enhances security measures by configuring default network access restrictions for storage accounts. By default, storage accounts accept connections from clients on any network. However, with this policy, the default action is modified to limit access exclusively to selected networks. This additional layer of security helps fortify resources against unauthorized access."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_035
#   severity: MEDIUM
package lib.azurearm.CB_AZR_035

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
	properties.defaultAction != "Deny"
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Default network access rule for Storage Accounts is set to deny.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Default network access rule for Storage Accounts is not set to deny.",
		"snippet": block,
	}
}
