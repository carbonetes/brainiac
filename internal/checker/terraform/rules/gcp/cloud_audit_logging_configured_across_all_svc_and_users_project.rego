# METADATA
# title: "Verify that Cloud Audit Logging is configured properly across all services and all users from a project"
# description: "This ensures comprehensive and accurate logging of activities within Google Cloud services, providing visibility into user actions and enhancing security monitoring and compliance efforts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_audit_config
# custom:
#   id: CB_TFGCP_105
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_105

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"google_project_iam_audit_config" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_project[label] {
	some block in input
	block.Type == "resource"
	"google_project" in block.Labels
	label := concat(".", block.Labels)
}

iam_connected_to_project(block){
	some label in label_for_project
	contains(block.Attributes.project, label)
}

fail[block] {
	some block in input
	isvalid(block)
	iam_connected_to_project(block)
	block.Attributes.service == "allServices"
	some inner_block in block.Blocks
	withMembers(inner_block)
}

withMembers(block) := true if {
	block.Type == "audit_log_config"
	count(block.Attributes.exempted_members) > 0
}


pass[block] {
	some block in input
	isvalid(block)
	iam_connected_to_project(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cloud Audit Logging is configured properly across all services and all users from a project.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cloud Audit Logging should be configured properly across all services and all users from a project.",
		"snippet": block,
	}
}
