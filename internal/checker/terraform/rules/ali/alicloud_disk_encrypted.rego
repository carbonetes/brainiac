# METADATA
# title: "Guarantee the encryption of Alibaba Cloud Disk"
# description: "Verify that Alibaba Cloud Disk data is safeguarded through encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/disk
# custom:
#   id: CB_TFALI_036
#   severity: MEDIUM
package lib.terraform.CB_TFALI_036

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_disk" in block.Labels
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
	block.Attributes.encrypted == true
    not "snapshot_id" in object.keys(block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud Disk encryption is set to true.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud Disk encryption must be set to true.",
		"snippet": block,
	}
}
