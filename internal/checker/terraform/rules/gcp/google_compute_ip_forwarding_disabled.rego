# METADATA
# title: "Verify IP Forwarding is Disabled on Instances"
# description: "This policy checks whether IP forwarding is enabled on virtual machine instances in the project. Enabling IP forwarding allows the instance to forward traffic, potentially posing a security risk."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_from_template
# custom:
#   id: CB_TFGCP_077
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_077

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_compute_instance", "google_compute_instance_from_template", "google_compute_instance_template"]
	block.Type == "resource"
	some label in block.Labels
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

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.can_ip_forward == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attribute.name == []
	not startswith(resource.Attribute.name, "gke-")
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Attribute.can_ip_forward != true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The instances are configured with IP forwarding disabled, enhancing network security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IP forwarding is enabled on one or more instances, increasing the risk of unauthorized traffic forwarding.",
		"snippet": block,
	}
}
