# METADATA
# title: "Verify GCP Cloud Run Service Access Restrictions"
# description: "This policy ensures that GCP Cloud Run services are configured to restrict access, preventing unauthorized exposure to the public or anonymous users."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam
# custom:
#   id: CB_TFGCP_116
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_116

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_cloud_run_service_iam_member", "google_cloud_run_service_iam_binding"]
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

invalid_members := [
	"allUsers",
	"allAuthenticatedUsers",
]

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Type == "resource"
	"google_cloud_run_service_iam_member" in resource.Labels
	resource.Attributes.member in invalid_members
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Type == "resource"
	"google_cloud_run_service_iam_binding" in resource.Labels
	some members in resource.Attributes.members
	members in invalid_members
}

passed[result] {
	some block in pass
	result := {
		"message": "GCP Cloud Run services do not allow anonymous or public access, enhancing security by restricting exposure.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GCP Cloud Run services are configured to allow anonymous or public access, posing a security risk. Update the configuration to restrict access for improved security.",
		"snippet": block,
	}
}
