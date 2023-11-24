# METADATA
# title: "Verify Cloud Functions are Not Publicly Accessible"
# description: "This policy ensures that Google Cloud Functions are not publicly accessible. Restricting public access enhances the security of Cloud Functions."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam
# custom:
#   id: CB_TFGCP_121
#   severity: HIGH
package lib.terraform.CB_TFGCP_121

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"google_cloudfunctions_function_iam_member",
		"google_cloudfunctions_function_iam_binding",
		"google_cloudfunctions2_function_iam_member",
		"google_cloudfunctions2_function_iam_binding"
	]
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
	resource.Attributes.member == "allUsers"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some member in resource.Attributes.members
	member == "allUsers"
}

passed[result] {
	some block in pass
	result := {
		"message": "Cloud Functions are configured to deny public access, ensuring enhanced security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cloud Functions are publicly accessible. Update the configuration to restrict public access and enhance security.",
		"snippet": block,
	}
}
