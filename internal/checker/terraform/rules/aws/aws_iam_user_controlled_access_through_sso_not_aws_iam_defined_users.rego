# METADATA
# title: "Verify that access is managed via Single Sign-On (SSO) rather than AWS IAM defined users"
# description: "Implement access control through Single Sign-On (SSO) instead of AWS IAM-defined users to enhance security and user management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user
# custom:
#   id: CB_TFAWS_249
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_249

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_user"
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
}

passed := []

failed contains resource if {
	some block in fail
	result := {
		"message": "Access is granted to AWS IAM defined users.",
		"snippet": block,
	}
}
