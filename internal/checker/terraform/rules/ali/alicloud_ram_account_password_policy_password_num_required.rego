# METADATA
# title: "Verify that the RAM password policy mandates the inclusion of at least one numeric character"
# description: "Confirm that the RAM password policy necessitates the presence of at least one numerical character, enhancing security measures and ensuring robust access control."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_023
#   severity: MEDIUM
package lib.terraform.CB_TFALI_023

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
	resource.Attributes.require_numbers == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM password policy contains one number or more.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "At least one number is required in RAM password policy.",
		"snippet": block,
	}
}
