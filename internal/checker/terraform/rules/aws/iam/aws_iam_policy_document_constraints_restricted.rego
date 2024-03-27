# METADATA
# title: "Make certain IAM policies prohibit unrestricted write access"
# description: "This policy permits activities that enable the alteration of resource-based policies or that, in other ways, may expose AWS resources to the public through comparable actions that may similarly expose resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_102
#   severity: LOW
package lib.terraform.CB_TFAWS_102

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
	noconstraints := [
		"s3:*",
		"S3:PutObject",
		"dynamodb:PutItem",
		"sns:Publish",
		"sqs:SendMessage",
		"lambda:InvokeFunction",
		"rds:CreateDBInstance",
		"ec2:RunInstances",
		"cloudformation:CreateStack",
		"sagemaker:CreateTrainingJob",
		"kinesis:PutRecord", "*",
	]
	some block in input
	isvalid(block)
	some blockstatements in block.Blocks
	blockstatements.Type == "statement"
	attribute := blockstatements.Attributes
	attribute.effect == "Allow"
	some action in attribute.actions
	action in noconstraints
	some resource in attribute.resources
	resource == "*"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "IAM policies restrict write access without constraints.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IAM policies should restrict write access without constraints.",
		"snippet": block,
	}
}
