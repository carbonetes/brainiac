# METADATA
# title: "Administers a Flow Log within a Network Watcher Log retention period is greater than or equal 90 days"
# description: "This involves overseeing and controlling the activities and data captured by a Flow Log within a Network Watcher, typically to monitor and analyze network traffic and performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log
# custom:
#   id: CB_TFAZR_032
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_032

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_network_watcher_flow_log" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	some innerBlock in resource.Blocks
	isvalid(resource)
	innerBlock.Type == "retention_policy"
	to_number(innerBlock.Attributes.days) >= 90
	innerBlock.Attributes.enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Network Watcher Flow Log has been successfully managed greater than equal 90 days, ensuring effective monitoring and analysis of network traffic and performance.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Unfortunately, the attempt to manage the Network Watcher Flow Log was unsuccessful. Should be greater than equal 90 days.",
		"snippet": block,
	}
}