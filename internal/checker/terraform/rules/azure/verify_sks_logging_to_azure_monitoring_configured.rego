# METADATA
# title: "Verify AKS logging to Azure Monitoring is Configured"
# description: "To effectively monitor and troubleshoot AKS clusters, it's essential to configure logging and telemetry data collection to Azure Monitoring."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_051
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_051

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kubernetes_cluster" in block.Labels
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
	isvalid(resource)
	some innerBlock in resource.Blocks
	innerBlock.Type == "addon_profile"
	some addonBlock in innerBlock.Blocks
	addonBlock.Type == "oms_agent"
	addonBlock.Attributes.enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some innerBlock in resource.Blocks
	innerBlock.Type == "oms_agent"
	innerBlock.Attributes.log_analytics_workspace_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS logging to Azure Monitoring is Configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS logging to Azure Monitoring should be Configured.",
		"snippet": block,
	}
}
