# METADATA
# title: "Make sure IAM password policy requires at least one symbol"
# description: "Requiring the use of symbols in passwords can make them more complex and harder to guess or crack through brute-force attacks, therefore increasing the security of the IAM user accounts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#require_symbols
# custom:
#   id: CB_TFAWS_015
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_015

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
    resource.Attributes.require_symbols = true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_iam_account_password_policy' 'require_symbols' is set properly.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_iam_account_password_policy' 'require_symbols' should be set to true",
                "snippet": block }
}