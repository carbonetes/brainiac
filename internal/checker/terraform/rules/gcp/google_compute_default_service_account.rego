# METADATA
# title: "Verify Instances Do Not Use Default Service Account"
# description: "This policy ensures that instances are not configured to use the default service account. Using default service accounts can pose security risks by granting unnecessary permissions."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_049
#   severity: HIGH
package lib.terraform.CB_TFGCP_049

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
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Instances are not configured to use the default service account, reducing security risks associated with unnecessary permissions.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Instances are configured to use the default service account, posing potential security risks. Configure instances with specific service accounts to restrict permissions.",
		"snippet": block,
	}
}
