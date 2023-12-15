# METADATA
# title: "Guarantee that the password policy for RAM mandates password expiration within a period of 90 days or fewer"
# description: "Confirm that the RAM password policy is configured to enforce password expiration within a timeframe of 90 days or fewer. This measure enhances security by regularly prompting users to update their passwords, contributing to a robust access control strategy."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_025
#   severity: LOW
package lib.terraform.CB_TFALI_025

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
	to_number(resource.Attributes.max_password_age) <= 90
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM password policy is configured to enforce password expiration within a timeframe of 90 days or fewer.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM password policy must be configured to enforce password expiration within a timeframe of 90 days or fewer.",
		"snippet": block,
	}
}
