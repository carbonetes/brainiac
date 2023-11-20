# METADATA
# title: "Verify that retention policies on log buckets are configured using Bucket Lock"
# description: "This ensures that retention policies for log buckets are set using Bucket Lock, enhancing data integrity and compliance by preventing accidental or malicious deletion of logs within Google Cloud Storage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_104
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_104

import future.keywords.in
import future.keywords.if

isvalid(block) {
	block.Type == "resource"
	"google_storage_bucket" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_folder_sink[label] {
	some block in input
	block.Type == "resource"
	"google_logging_folder_sink" in block.Labels
	label := concat(".", block.Labels)
}

label_for_project_sink[label] {
	some block in input
	block.Type == "resource"
	"google_logging_project_sink" in block.Labels
	label := concat(".", block.Labels)
}

label_for_organization_sink[label] {
	some block in input
	block.Type == "resource"
	"google_logging_project_sink" in block.Labels
	label := concat(".", block.Labels)
}

logging_sinked {
	some block in input
	block.Type == "resource"
	"google_storage_bucket" in block.Labels
	some inner_block in block.Blocks
	inner_block.Type == "logging"
	check_logging_label(inner_block)
}

check_logging_label(block) := true if {
	some label in label_for_folder_sink
	contains(block.Attributes.log_bucket_name, label)
} else := true if {
	some label in label_for_project_sink
	contains(block.Attributes.log_bucket_name, label)
} else := true if {
	some label in label_for_organization_sink
	contains(block.Attributes.log_bucket_name, label)
}

fail[block] {
	some block in input
	block.Type == "resource"
	"google_storage_bucket" in block.Labels
	some inner_block in block.Blocks
	inner_block.Type == "retention_policy"
	logging_sinked
	inner_block.Attributes.is_locked == false
}

pass[block] {
	some block in input
	isvalid(block)
	logging_sinked
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Retention policies on log buckets are configured using Bucket Lock.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Retention policies on log buckets shoul be configured using Bucket Lock.",
		"snippet": block,
	}
}
