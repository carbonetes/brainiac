# METADATA
# title: "Guarantee that Action Trail Logging is active in every region"
# description: "Verify the activation of Action Trail Logging across all regions, confirming comprehensive monitoring and logging of actions for enhanced security and auditing capabilities in the entire environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/actiontrail_trail
# custom:
#   id: CB_TFALI_004
#   severity: LOW
package lib.terraform.CB_TFALI_004

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_actiontrail_trail" in block.Labels
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
	block.Attributes.trail_region == "All"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Action Trail Logging is active in every region.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Action Trail Logging must be active in every region.",
		"snippet": block,
	}
}
