# METADATA
# title: "Verify Instances Do Not Override Project OS Login Setting"
# description: "This policy ensures that no instance in the project overrides the project-wide setting for enabling OS Login. OS Login should be enabled in the project metadata for all instances to maintain a consistent and secure access control configuration."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata
# custom:
#   id: CB_TFGCP_071
#   severity: HIGH
package lib.terraform.CB_TFGCP_071

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
    not resource.Attributes.source_instance_template
	resource.Attributes.metadata["enable-oslogin"] == true
}


fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "All instances adhere to the project-wide OS Login setting, ensuring a consistent and secure access control configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some instances override the project-wide OS Login setting. Adjust instance configurations to align with the project setting for OS Login, ensuring a consistent and secure access control configuration.",
		"snippet": block,
	}
}