# METADATA
# title: "Verify that transfer acceleration is activated for the OSS bucket"
# description: "Confirm that transfer acceleration is active for the OSS bucket, enhancing data transfer speed and efficiency by leveraging Alibaba Cloud's acceleration services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/oss_bucket
# custom:
#   id: CB_TFALI_015
#   severity: LOW
package lib.terraform.CB_TFALI_015

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
	inner_block.Type == "transfer_acceleration"
	inner_block.Attributes.enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The transfer acceleration is activated for the OSS bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The transfer acceleration must be activated for the OSS bucket.",
		"snippet": block,
	}
}
