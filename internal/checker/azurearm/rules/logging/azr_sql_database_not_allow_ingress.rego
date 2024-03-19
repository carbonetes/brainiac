# METADATA
# title: "Verify Azure SQL databases do not allow ingress from 0.0.0.0/0"
# description: "This policy ensures Azure SQL Databases restrict ingress from 0.0.0.0/0, enhancing security by preventing unauthorized access."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_011
#   severity: CRITICAL
package lib.azurearm.CB_AZR_011

import future.keywords.in

is_valid {
	supported_resources := ["Microsoft.Sql/servers/firewallRules", "firewallRules", "firewallrules"]
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

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	ip_address := ["0.0.0.0", "0.0.0.0/0"]
	properties.startIpAddress in ip_address
	properties.endIpAddress == "255.255.255.255"
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure SQL databases do not allow ingress from 0.0.0.0/0.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure SQL databases allows ingress from 0.0.0.0/0.",
		"snippet": block,
	}
}
