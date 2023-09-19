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
    contains(resource.Attributes.categories[_], "Action")
    contains(resource.Attributes.categories[_], "Delete")
    contains(resource.Attributes.categories[_], "Write")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The audit profile comprehensively records every action.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The audit profile must comprehensively record every action.",
                "snippet": block }
} 