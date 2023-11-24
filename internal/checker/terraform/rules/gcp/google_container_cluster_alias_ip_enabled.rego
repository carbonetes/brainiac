# METADATA
# title: "Verify Kubernetes Cluster Enables Alias IP Ranges"
# description: "This policy verifies that Kubernetes clusters are created with Alias IP ranges enabled, which is essential for certain network configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_012
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_012

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
	block.Type == "ip_allocation_policy"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes cluster is configured with Alias IP ranges enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kubernetes clusters should be created with Alias IP ranges enabled.",
		"snippet": block,
	}
}