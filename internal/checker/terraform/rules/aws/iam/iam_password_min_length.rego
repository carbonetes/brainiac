# METADATA
# title: "Make sure IAM password policy requires minimum length of 14 or greater."
# description: "Passwords that are too short or too simple can be easily guessed or cracked, which can lead to unauthorized access to sensitive resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#minimum_password_length
# custom:
#   id: CB_TFAWS_009
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_009

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
	maxpasswordlength := to_number(resource.Attributes.minimum_password_length)
	maxpasswordlength >= 14
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_iam_account_password_policy' 'minimum_password_length' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_iam_account_password_policy' 'minimum_password_length' should be set to 14 or greater",
		"snippet": block,
	}
}
