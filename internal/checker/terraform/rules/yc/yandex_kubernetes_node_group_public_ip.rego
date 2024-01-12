# METADATA
# title: "Avoid Public IP Addresses in Kubernetes Cluster Node Groups"
# description: "This policy ensures that node groups within a Kubernetes cluster do not have public IP addresses assigned, minimizing potential security risks and exposure to external threats."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_node_group
# custom:
#   id: CB_TFYC_006
#   severity: LOW
package lib.terraform.CB_TFYC_006

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_node_group" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "instance_template"
	some network_interface in block.Blocks
	network_interface.Type == "network_interface"
	network_interface.Attributes.nat == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster node group does not have any public IP addresses, aligning with security best practices.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public IP addresses are assigned to nodes in the Kubernetes cluster node group. It is recommended to avoid using public IPs for enhanced security.",
		"snippet": block,
	}
}
