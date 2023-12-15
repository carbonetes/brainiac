# METADATA
# title: "Verify RAM Account Password Policy Max Login Attempts"
# description: "This policy checks whether the Max Login Attempts setting for RAM (Resource Access Management) accounts is not greater than 5. Limiting login attempts enhances security by preventing brute force attacks."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_008
#   severity: MEDIUM
package lib.terraform.CB_TFALI_008

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
	to_number(resource.Attributes.max_login_attempts) <= 5
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM Account Password Policy Max Login Attempts is appropriately configured (not exceeding 5), promoting enhanced security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM Account Password Policy Max Login Attempts is set to a value greater than 5. Adjust the setting to a maximum of 5 for improved security against brute force attacks.",
		"snippet": block,
	}
}
