# METADATA
# title: "Verify that the RAM password policy mandates a minimum length of 14 characters or more"
# description: "Confirm that the RAM password policy mandates a minimum length of 14 characters or more, enhancing security measures and access control."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_019
#   severity: MEDIUM
package lib.terraform.CB_TFALI_019

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_ram_account_password_policy" in block.Labels
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
	to_number(resource.Attributes.minimum_password_length) >= 14
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM password policy has a minimum length of 14 characters or more.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM password policy must have a minimum length of 14 characters or more.",
		"snippet": block,
	}
}
