# METADATA
# title: "Verify that access logging is activated for the OSS bucket"
# description: "Confirm that access logging is active for the OSS bucket to track and log detailed information about access requests, enhancing visibility and aiding in security analysis and compliance monitoring."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
# custom:
#   id: CB_TFALI_016
#   severity: LOW
package lib.terraform.CB_TFALI_016

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_oss_bucket" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "logging"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The access logging is activated for the OSS bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The access logging must be activated for the OSS bucket.",
		"snippet": block,
	}
}
