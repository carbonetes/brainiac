# METADATA
# title: "Confirm that the Activity Log Retention is configured for a duration equal to or exceeding 365 days"
# description: "Please verify that the Activity Log Retention is configured to retain data for a period of 365 days or longer. This extended retention period helps in preserving essential activity logs and audit information for an extended duration, facilitating compliance and historical analysis of system events and activities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_log_profile
# custom:
#   id: CB_TFAZR_018
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_018

import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "azurerm_monitor_log_profile" in block.Labels
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
    some inner_block in resource.Blocks
    inner_block.Type == "retention_policy"
    to_number(inner_block.Attributes.days) >= 365
}

pass[resource]{
    some resource in input
	isvalid(resource)
    some inner_block in resource.Blocks
    inner_block.Type == "retention_policy"
    inner_block.Attributes.enabled == false
}

fail[block] {
    some block in input
	isvalid(block)
   	not pass[block]
}

passed[result] {
	some block in pass
	result := { 
        "message": "The Activity Log Retention is configured for a duration equal to or exceeding 365 days",
        "snippet": block, 
    }
}

failed[result] {
    some block in fail
	result := { 
        "message": "The Activity Log Retention must be configured for a duration equal to or exceeding 365 days",
        "snippet": block,
    }
} 