# METADATA
# title: "Verify VPC Flow Logs for All Subnets in a VPC Network"
# description: "This policy validates whether VPC Flow Logs are enabled for every subnet within a Virtual Private Cloud (VPC) network. Enabling VPC Flow Logs provides crucial network traffic visibility and enhances security."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# custom:
#   id: CB_TFGCP_025
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_025

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"google_compute_subnetwork" in resource.Labels
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
	resource.Attributes.purpose == "INTERNAL_HTTPS_LOAD_BALANCER"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	not block.Type == "log_config"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "VPC Flow Logs are enabled for all subnets in the VPC network, ensuring comprehensive network traffic monitoring.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Not all subnets in the VPC network have VPC Flow Logs enabled, potentially limiting network traffic visibility.",
		"snippet": block,
	}
}