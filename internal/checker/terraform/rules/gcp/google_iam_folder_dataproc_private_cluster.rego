# METADATA
# title: "Verify Dataproc Clusters Restrict Public Access"
# description: "This policy ensures that Dataproc clusters are configured to restrict public access, preventing unauthorized exposure to the public internet."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_cluster_iam
# custom:
#   id: CB_TFGCP_108
#   severity: HIGH
package lib.terraform.CB_TFGCP_108

import future.keywords.in

isvalid(block) {
	supported_resources := ["google_dataproc_cluster_iam_member", "google_dataproc_cluster_iam_binding"]
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
	"google_dataproc_cluster_iam_member" in resource.Labels
	resource.Attributes.member in invalid_members
}

fail[resource] {
	some resource in input
	isvalid(resource)
	resource.Type == "resource"
	"google_dataproc_cluster_iam_binding" in resource.Labels
	some members in resource.Attributes.members
	members in invalid_members
}
 
passed[result] {
	some block in pass
	result := {
		"message": "Dataproc clusters do not allow anonymous or public access, enhancing security by restricting exposure to the public internet.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Dataproc clusters are configured to allow anonymous or public access, posing a security risk. Update the configuration to restrict public access for improved security.",
		"snippet": block,
	}
}
