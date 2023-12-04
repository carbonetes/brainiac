# METADATA
# title: "Verify that the RAM password policy mandates the inclusion of at least one special character"
# description: "Confirm that the RAM password policy necessitates the presence of at least one symbol, strengthening security measures and assuring comprehensive access control."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_024
#   severity: MEDIUM
package lib.terraform.CB_TFALI_024

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
	resource.Attributes.require_symbols == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The RAM Account Password Policy contains one or more special characters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "At least one special character is needed for RAM Account Password Policy.",
		"snippet": block,
	}
}
