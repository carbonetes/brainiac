# METADATA
# title: "Use Container-Optimized OS (COS) for Kubernetes Engine Node Images"
# description: "This policy ensures that Kubernetes clusters have proper labels configured, enhancing resource management and organization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_004
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_004

import future.keywords.in
import future.keywords.if

isvalid(resource) {
	resource.Type == "resource"
	"google_container_node_pool" in resource.Labels
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
    validate_config(resource)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.remove_default_node_pool
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

validate_config(resource) if {
	some block in resource.Blocks
	block.Type == "node_config"
	image_type := block.Attributes.image_type
	image_type != ""
	startswith(lower(image_type), "cos")
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes clusters are configured with appropriate labels.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kubernetes clusters lack proper label configuration, impacting resource management and organization.",
		"snippet": block,
	}
}
