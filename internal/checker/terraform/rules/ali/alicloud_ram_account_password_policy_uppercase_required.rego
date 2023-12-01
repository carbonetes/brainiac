# METADATA
# title: "Verify that the password policy for RAM (Resource Access Management) mandates the inclusion of at least one uppercase letter for enhanced security"
# description: "Guarantee the enforcement of a RAM (Resource Access Management) password policy that mandates the presence of at least one uppercase letter, reinforcing robust security measures for authentication."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_account_password_policy
# custom:
#   id: CB_TFALI_028
#   severity: MEDIUM
package lib.terraform.CB_TFALI_028

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
	resource.Attributes.require_uppercase_characters == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM password policy contains at least one uppercase letter.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM password policy must have at least one uppercase letter.",
		"snippet": block,
	}
}
