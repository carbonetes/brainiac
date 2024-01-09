# METADATA
# title: "Assign Security Group to Kubernetes Cluster"
# description: "This policy ensures that a security group is appropriately assigned to a Kubernetes cluster. Assigning security groups helps in implementing network security controls, allowing only authorized traffic to and from the Kubernetes cluster."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFYC_014
#   severity: LOW
package lib.terraform.CB_TFYC_014

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_cluster" in block.Labels
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
	block.Type == "master"
	count(block.Attributes.security_group_ids) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster has a security group assigned, enhancing network security measures.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "No security group is assigned to the Kubernetes cluster. It is recommended to associate a security group to enforce network security controls effectively.",
		"snippet": block,
	}
}
