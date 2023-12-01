# METADATA
# title: "Guarantee that the RAM password policy inhibits the reuse of passwords"
# description: "Verify that the the password policy for RAM (Resource Access Management) prohibits the reuse of passwords to enhance security."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_027
#   severity: MEDIUM
package lib.terraform.CB_TFALI_027

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
	to_number(resource.Attributes.password_reuse_prevention) >= 24
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM Account Password Policy prevents the reuse of passwords.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM Account Password Policy must prevent the reuse of passwords.",
		"snippet": block,
	}
}
