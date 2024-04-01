# METADATA
# title: "Make certain that IAM policies prohibit managing permissions and exposing resources without restrictions"
# description: "This policy enables actions that allow for the alteration of resource-based policies or have the potential to expose AWS resources to the public. These actions have similarities to actions that can lead to the exposure of resources, which may pose security and confidentiality risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_115
#   severity: LOW
package lib.terraform.CB_TFAWS_115

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
	noconstraints := ["iam:*", "ec2:*", "s3:*", "sns:*", "sqs:*", "lambda:*", "kms:*", "cloudformation:*", "rds:*", "*"]
	some block in input
	isvalid(block)
	some blockstatements in block.Blocks
	blockstatements.Type == "statement"
	attribute := blockstatements.Attributes
	attribute.effect == "Allow"
	some action in attribute.actions
	action in noconstraints
	some resources in attribute.resources
	resources == "*"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "IAM policies restrict permissions management / resource exposure without constraints.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IAM policies should restrict permissions management / resource exposure without constraints.",
		"snippet": block,
	}
}