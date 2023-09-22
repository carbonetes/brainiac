# METADATA
# title: "Administers a Flow Log within a Network Watcher"
# description: "This involves overseeing and controlling the activities and data captured by a Flow Log within a Network Watcher, typically to monitor and analyze network traffic and performance"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log
# custom:
#   id: CB_TFAZR_032
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_032

import future.keywords.if

supportedResource := ["azurerm_network_watcher_flow_log"]

isvalid(block) if {
	block.Type == "resource"
	block.Labels[_] == supportedResource[_]
}

pass[resource] {
	resource := input[_]
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	resource := input[_]
	innerBlock := resource.Blocks[_]
	isvalid(resource)
    innerBlock.Type == "retention_policy" 
	innerBlock.Attributes.enabled == true
	days_as_int := resource.days
	days_as_int >= 90
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The Network Watcher Flow Log has been successfully managed, ensuring effective monitoring and analysis of network traffic and performance.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Unfortunately, the attempt to manage the Network Watcher Flow Log was unsuccessful. Please check your configuration and try again.",
		"snippet": block,
	}
}
