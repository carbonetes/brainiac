# METADATA
# title: "Make sure IAM password policy requires at least one number"
# description: "Requiring at least one number in IAM password policy ensures that passwords are more complex and less susceptible to being guessed or easily cracked by attackers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_numbers
# custom:
#   id: CB_TFAWS_012
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_012

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_account_password_policy"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.require_numbers = true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_iam_account_password_policy' 'require_numbers' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_iam_account_password_policy' 'require_numbers' should be set to true",
		"snippet": block,
	}
}
