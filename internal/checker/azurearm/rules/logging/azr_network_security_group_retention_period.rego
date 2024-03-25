# METADATA
# title: "Verify Network Security Group Flow Log retention period is greater than 90 days"
# description: "This policy ensures Network Security Group flow logs retain data for at least 90 days, aiding in monitoring and breach detection."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.network/networkwatchers/flowlogs?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_012
#   severity: MEDIUM
package lib.azurearm.CB_AZR_012

import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Network/networkWatchers/flowLogs", "Microsoft.Network/networkWatchers/FlowLogs"]
	some resource in input.resources
	resource.type in supported_resources
}

resource[type] {
	some resource in input.resources
	is_valid
	count(fail) > 0
	type := resource.type
}

resource[type] {
	some resource in input.resources
	is_valid
	count(pass) > 0
	type := resource.type
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties.retentionPolicy
	properties.enabled == true
	properties.days >= 90
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Network Security Group Flow Log retention period is greater than 90 days.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Network Security Group Flow Log retention period is less than 90 days.",
		"snippet": block,
	}
}
