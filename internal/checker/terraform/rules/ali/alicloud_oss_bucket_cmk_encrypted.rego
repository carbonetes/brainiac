# METADATA
# title: "Verify that the OSS bucket is protected with a Customer Master Key for encryption"
# description: "Confirm the OSS bucket employs encryption using a Customer Master Key to enhance data security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
# custom:
#   id: CB_TFALI_012
#   severity: MEDIUM
package lib.terraform.CB_TFALI_012

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

fail[block] {
	some block in input
	isvalid(block)
    some inner_block in block.Blocks
    inner_block.Type == "server_side_encryption_rule"
	inner_block.Attributes.kms_master_key_id == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The OSS bucket is protected with a Customer Master Key for encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The OSS bucket must be protected with a Customer Master Key for encryption.",
		"snippet": block,
	}
}
