# METADATA
# title: "Verify Application of Security Context to Pods and Containers"
# description: "This policy ensures the application of security context to pods, deployments, and daemon sets in Kubernetes environments. Security context settings include parameters such as user and group IDs, file permissions, and other attributes that contribute to the security of containerized workloads."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
# custom:
#   id: CB_TFK8S_017
#   severity: LOW
package lib.terraform.CB_TFK8S_017

import future.keywords.in

isvalid(resource) {
	supported_resources := [
		"kubernetes_deployment",
        "kubernetes_deployment_v1",
        "kubernetes_pod",
        "kubernetes_pod_v1"
	]
	resource.Type == "resource"
	some label in resource.Labels
	label in supported_resources
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
    some spec_block in resource.Blocks
    spec_block.Type == "spec"
    some template_block in spec_block.Blocks
    template_block.Type == "template"
	some template_spec_block in template_block.Blocks
    template_spec_block.Type == "spec"
    some spec_container_block in template_spec_block.Blocks
    spec_container_block.Type == "container"
    some container_security_context_block in spec_container_block.Blocks
    container_security_context_block.Type == "security_context"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Security context is appropriately applied to pods and containers, contributing to a secure Kubernetes environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security context is not adequately applied to pods and containers, potentially exposing security vulnerabilities. Apply relevant security context settings to enhance the security of containerized workloads.",
		"snippet": block,
	}
}
