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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "azurerm_monitor_log_profile"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "retention_policy"
    to_number(resource.Blocks[_].Attributes.days) >= 365
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "retention_policy"
    resource.Blocks[_].Attributes.enabled == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The Activity Log Retention is configured for a duration equal to or exceeding 365 days",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The Activity Log Retention must be configured for a duration equal to or exceeding 365 days",
                "snippet": block }
} 