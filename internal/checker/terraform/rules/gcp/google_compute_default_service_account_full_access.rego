# METADATA
# title: "Verify instances do not use the default service account with full access to all Cloud APIs"
# description: "This policy verifies that instances are not configured to use the default service account with unrestricted access to all Cloud APIs. Utilizing the default service account with broad permissions poses a security risk, as it grants unnecessary privileges that can lead to unauthorized access and potential security breaches."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_041
#   severity: HIGH
package lib.terraform.CB_TFGCP_041

import future.keywords.if
import future.keywords.in

isvalid(block) if {
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
	resource.Attributes.name == []
	startswith(resource.Attributes.name, "gke-")
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "service_account"
	not resource.Attributes.source_instance_template
}

pass[resource] {
	default_service_account := "compute@developer.gserviceaccount.com"
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "service_account"
	contains(block.Attributes.email, default_service_account)
	count(block.Attributes.scopes) > 0
	check_service_account(block.Attributes.scopes) == true
}

check_service_account(scopes) := true if {
	not "https://www.googleapis.com/auth/cloud-platform" in scopes
} else := true if {
	not "cloud-platform" in scopes
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Instances are configured correctly and do not use the default service account with full access to all Cloud APIs.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Instances are configured to use the default service account with full access to all Cloud APIs, posing a high security risk. Adjust instance configurations to limit permissions and enhance security.",
		"snippet": block,
	}
}
