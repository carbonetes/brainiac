# METADATA
# title: "Make sure IAM password policy prevents password reuse"
# description: "It reduces the likelihood of unauthorized access to systems and data, as well as mitigates the risk of password-based attacks, such as brute-force attacks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy#password_reuse_prevention
# custom:
#   id: CB_TFAWS_013
#   severity: HIGH
package lib.terraform.CB_TFAWS_013

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
    reusepasswordint := to_number(resource.Attributes.password_reuse_prevention)
    reusepasswordint <= 24
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_iam_account_password_policy' 'password_reuse_prevention' is set properly.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_iam_account_password_policy' 'password_reuse_prevention' should be set to and to be set less than 24",
                "snippet": block }
}