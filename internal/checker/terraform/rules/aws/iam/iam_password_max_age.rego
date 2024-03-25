# METADATA
# title: "Make sure that the IAM password policy mandates passwords to expire within 90 days or less."
# description: "Passwords that remain unchanged for extended periods of time can be more easily compromised, as attackers may have more time to guess or obtain them."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#max_password_age
# custom:
#   id: CB_TFAWS_008
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_008

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
    maxage := to_number(resource.Attributes.max_password_age)
    maxage <= 90
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_iam_account_password_policy' 'max_password_age' is set properly.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_iam_account_password_policy' 'max_password_age' should be set to 90 days or less",
                "snippet": block }
}