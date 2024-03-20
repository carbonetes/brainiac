# METADATA
# title: "Verify Azure Cache for Redis disables public network access"
# description: "Confirming that Azure Cache for Redis has been configured to disable public network access is essential for bolstering security measures within the system."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.cache/redis?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_053
#   severity: LOW
package lib.azurearm.CB_AZR_053

import future.keywords.in

resource := "Microsoft.Cache/redis"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties]{
    is_valid
	some resource in input.resources
    properties := resource.properties
    properties.publicNetworkAccess == "Disabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure cache for Redis is disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure cache for Redis is enabled.",
		"snippet": block,
	}
}
