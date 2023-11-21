# METADATA
# title: "Verify BigQuery Tables Restrict Public Access"
# description: "This policy ensures that BigQuery Tables are configured to restrict public access, preventing unauthorized exposure to the public internet."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table_iam
# custom:
#   id: CB_TFGCP_111
#   severity: HIGH
package lib.terraform.CB_TFGCP_111

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_bigquery_table_iam_member", "google_bigquery_table_iam_binding"]
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
	"google_bigquery_table_iam_member" in resource.Labels
	resource.Attributes.member in invalid_members
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Type == "resource"
	"google_bigquery_table_iam_binding" in resource.Labels
	some members in resource.Attributes.members
	members in invalid_members
}

passed[result] {
	some block in pass
	result := {
		"message": "BigQuery Tables do not allow anonymous or public access, enhancing security by restricting exposure to the public internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "BigQuery Tables are configured to allow anonymous or public access, posing a security risk. Update the configuration to restrict public access for improved security.",
		"snippet": block,
	}
}
