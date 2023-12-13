# METADATA
# title: "Guarantee that the Disk is secured with a Customer Master Key for encryption"
# description: "Verify that the Disk is protected with encryption using a Customer Master Key for enhanced security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/disk
# custom:
#   id: CB_TFALI_030
#   severity: LOW
package lib.terraform.CB_TFALI_030

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
	"kms_key_id" in object.keys(block.Attributes)
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
		"message": "The Disk is secured with a Customer Master Key for encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Disk is secured with a Customer Master Key for encryption.",
		"snippet": block,
	}
}
