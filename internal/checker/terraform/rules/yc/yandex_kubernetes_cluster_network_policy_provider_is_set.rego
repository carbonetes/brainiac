# METADATA
# title: "Assign Network Policy to Kubernetes Cluster"
# description: "This policy ensures that a network policy is appropriately assigned to a Kubernetes cluster. Network policies define how groups of pods communicate with each other and other network endpoints, providing an additional layer of security for Kubernetes cluster communications."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFYC_016
#   severity: LOW
package lib.terraform.CB_TFYC_016

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
	resource.Attributes.network_policy_provider != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster has a network policy assigned, enhancing control over pod communication within the cluster.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "No network policy is assigned to the Kubernetes cluster. It is recommended to define and apply a network policy for improved security in pod communication.",
		"snippet": block,
	}
}
