# METADATA
# title: "Verify that the audit profile comprehensively records every action"
# description: "Verify that the audit profile effectively logs a complete range of system actions, leaving no critical activities unrecorded."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_log_profile
# custom:
#   id: CB_TFAZR_030
#   severity: LOW
package lib.terraform.CB_TFAZR_030

import future.keywords.in

isvalid(resource) {
	supported_resources := ["azurerm_sql_firewall_rule", "azurerm_monitor_log_profile"]
	resource.Type == "resource"
	some label in resource.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource]{
    some resource in input
	isvalid(resource)
    "Action" in resource.Attributes.categories
    "Delete" in resource.Attributes.categories
    "Write" in resource.Attributes.categories
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
    some block in pass
	result := { 
		"message": "The audit profile comprehensively records every action.",
        "snippet": block, 
	}
}

failed[result] {
    some block in fail
	result := { 
		"message": "The audit profile must comprehensively record every action.",
        "snippet": block, 
	}
}