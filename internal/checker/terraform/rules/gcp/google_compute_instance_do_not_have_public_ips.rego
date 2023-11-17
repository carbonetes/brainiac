# METADATA
# title: "Verify Compute Instances Without Public IP Addresses"
# description: "This policy ensures that Shielded VM is enabled when launching compute instances. Shielded VM provides additional protection against various attacks, enhancing the security posture of the instances."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_088
#   severity: HIGH
package lib.terraform.CB_TFGCP_088

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

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "network_interface"
    some innerblock in block.Blocks
	innerblock.Type == "access_config"
}

passed[result] {
	some block in pass
	result := {
		"message": " Compute instances do not have public IP addresses assigned, enhancing security by limiting exposure to external networks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public IP addresses are assigned to one or more compute instances, increasing the risk of potential external threats.",
		"snippet": block,
	}
}
