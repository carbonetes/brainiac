# METADATA
# title: "Verify the PodSecurityPolicy controller is enabled on Kubernetes Engine Clusters"
# description: "This policy checks whether the PodSecurityPolicy (PSP) controller is enabled on Kubernetes Engine Clusters, enhancing security by defining and enforcing security policies for running pods."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_013
#   severity: HIGH
package lib.terraform.CB_TFGCP_013

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
	block.Type == "pod_security_policy_config"
	block.Attributes.enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The PodSecurityPolicy controller is enabled on the Kubernetes Engine Clusters, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The PodSecurityPolicy controller is not enabled on the Kubernetes Engine Clusters, leaving the cluster potentially vulnerable to security risks.",
		"snippet": block,
	}
}