# METADATA
# title: "Verify Kubernetes Cluster Private Cluster Setting"
# description: "This policy checks whether a Kubernetes cluster is created with the Private cluster setting enabled, which enhances network security by preventing public access to the cluster's control plane."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_024
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_024

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"google_container_cluster" in resource.Labels
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
	block.Type == "private_cluster_config"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster is created with Private cluster enabled, ensuring network security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Kubernetes cluster lacks Private cluster settings, potentially allowing unauthorized public access to the control plane.",
		"snippet": block,
	}
}
