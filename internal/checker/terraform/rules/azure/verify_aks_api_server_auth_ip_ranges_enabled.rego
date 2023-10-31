# METADATA
# title: "Verify AKS has an API Server Authorized IP Ranges enabled"
# description: "To enhance security and control, it's important to configure authorized IP ranges for the AKS API server. This means specifying the IP addresses or IP ranges from which API server requests are allowed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_055
#   severity: LOW
package lib.terraform.CB_TFAZR_055

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
	resource.Attributes.api_server_authorized_ip_ranges != ""
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.private_cluster_enabled != false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "AKS has an API Server Authorized IP Ranges enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AKS API Server should enabled Authorized IP Ranges.",
		"snippet": block,
	}
}
