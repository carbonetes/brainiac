# METADATA
# title: "Verify Shielded VM is Enabled for Compute Instances"
# description: "This policy ensures that Shielded VM is enabled when launching compute instances. Shielded VM provides additional protection against various attacks, enhancing the security posture of the instances."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_057
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_057

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
	block.Type == "shielded_instance_config"
    block.Attributes.enable_vtpm == true
    not block.Attributes.enable_vtpm == []
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "shielded_instance_config"
    block.Attributes.enable_integrity_monitoring == true
    not block.Attributes.enable_integrity_monitoring == []
} 


passed[result] {
	some block in pass
	result := {
		"message": "Compute instances are successfully launched with Shielded VM enabled, enhancing security against potential attacks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Shielded VM is not enabled for one or more compute instances, potentially exposing them to security vulnerabilities.",
		"snippet": block,
	}
}
