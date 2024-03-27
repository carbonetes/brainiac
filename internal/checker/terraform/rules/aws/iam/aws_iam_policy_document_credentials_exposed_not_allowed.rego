# METADATA
# title: "Make certain that IAM policies prohibit the disclosure of credentials"
# description: "Prevent credentials exposure in IAM policies for ECR by reviewing and modifying policies, applying the principle of least privilege, and implementing additional security measures like MFA."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_100
#   severity: LOW
package lib.terraform.CB_TFAWS_100

import rego.v1

isvalid(block) if {
	block.Type == "data"
	some label in block.Labels
	label == "aws_iam_policy_document"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains blockstatements if {
	credentialexposure := ["iam:CreateAccessKey", "iam:UpdateAccessKey", "sts:AssumeRole", "*"]
	some block in input
	isvalid(block)
	some blockstatements in block.Blocks
	blockstatements.Type == "statement"
    attribute := blockstatements.Attributes
    attribute.effect == "Allow"
	some action in attribute.actions
	action in credentialexposure
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_iam_policy_document' credentials are not exposed.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_iam_policy_document' credentials should not be exposed.",
		"snippet": block,
	}
}
