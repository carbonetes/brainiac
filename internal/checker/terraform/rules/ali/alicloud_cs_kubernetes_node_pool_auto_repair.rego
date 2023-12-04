# METADATA
# title: "Verify Kubernetes Node Pools Auto-Repair Configuration"
# description: "This policy checks whether Kubernetes (K8s) node pools are configured with auto-repair enabled. Auto-repair ensures that the node pool automatically replaces unhealthy nodes, enhancing cluster reliability."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool
# custom:
#   id: CB_TFALI_022
#   severity: LOW
package lib.terraform.CB_TFALI_022

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_cs_kubernetes_node_pool" in block.Labels
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
	some block in resource.Blocks
	block.Type == "management"
	block.Attributes.auto_repair == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Kubernetes node pools are configured to auto-repair, ensuring automatic replacement of unhealthy nodes for improved cluster reliability.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Auto-repair is not enabled for Kubernetes node pools. Enable auto-repair to automatically replace unhealthy nodes and enhance cluster resilience.",
		"snippet": block,
	}
}
