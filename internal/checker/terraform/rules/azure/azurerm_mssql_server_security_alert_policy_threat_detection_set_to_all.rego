# METADATA
# title: "Confirm 'Threat Detection types' are configured as 'All'"
# description: "Validate that the configuration for 'Threat Detection' types is set to 'All', confirming comprehensive threat detection coverage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_security_alert_policy
# custom:
#   id: CB_TFAZR_026
#   severity: HIGH
package lib.terraform.CB_TFAZR_026

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_mssql_server_security_alert_policy" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource]{
    some resource in input
	isvalid(resource)
    count(resource.Attributes.disabled_alerts) != 0
}

pass[block] {
    some block in input
	isvalid(block)
   	not fail[block]
}

passed[result] {
	some block in pass
	result := { 
		"message": "The 'Threat Detection types' are configured as 'All'",
        "snippet": block, 
	}
}

failed[result] {
    some block in fail
	result := { 
		"message": "The 'Threat Detection types' must be configured as 'All'",
        "snippet": block, 
	}
} 