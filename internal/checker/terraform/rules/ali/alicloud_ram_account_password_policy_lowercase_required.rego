# METADATA
# title: "Guarantee that the RAM password policy mandates the inclusion of at least one lowercase letter in passwords"
# description: "Verify that the RAM password policy enforces the inclusion of at least one lowercase letter in user passwords. This security measure enhances password complexity, contributing to a more robust access control framework."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_026
#   severity: MEDIUM
package lib.terraform.CB_TFALI_026

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
	resource.Attributes.require_lowercase_characters == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM password policy enforces the inclusion of at least one lowercase letter in user passwords.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM password policy must enforce the inclusion of at least one lowercase letter in user passwords.",
		"snippet": block,
	}
}
