# METADATA
# title: "Verify 'Block Project-wide SSH keys' is enabled for VM instances"
# description: "This policy checks if the 'Block Project-wide SSH keys' feature is enabled for VM instances. Enabling this feature enhances security by preventing the use of project-wide SSH keys, which could pose a risk to the integrity of VM instances."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_054
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_054

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
    resource.Attributes.metadata
	not resource.Attributes.source_instance_template
}

fail[resource] {
	some resource in input
	isvalid(resource)
    not "block-project-ssh-keys" in resource.Attributes.metadata
}

passed[result] {
	some block in pass
	result := {
		"message": "'Block Project-wide SSH keys' is correctly enabled for VM instances, enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'Block Project-wide SSH keys' is not enabled for VM instances, posing a security risk. Enable this feature to enhance VM instance security.",
		"snippet": block,
	}
}