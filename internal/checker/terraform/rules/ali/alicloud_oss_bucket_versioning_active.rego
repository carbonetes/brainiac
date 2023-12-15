# METADATA
# title: "Verify that versioning is activated for the OSS bucket"
# description: "Confirm that versioning is activated for the OSS bucket to maintain a history of object versions, assuring data integrity and facilitating recovery in case of accidental deletions or modifications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
# custom:
#   id: CB_TFALI_014
#   severity: LOW
package lib.terraform.CB_TFALI_014

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
	inner_block.Type == "versioning"
	inner_block.Attributes.status == "Enabled"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The versioning is activated for the OSS bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The versioning must be activated for the OSS bucket.",
		"snippet": block,
	}
}
