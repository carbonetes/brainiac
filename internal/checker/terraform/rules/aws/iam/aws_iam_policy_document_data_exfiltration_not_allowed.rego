# METADATA
# title: "Make certain that IAM policies prohibit data exfiltration"
# description: "Data Exfiltration actions, such as s3:GetObject, ssm:GetParameter*, or secretsmanager:GetSecretValue, permit some read-only IAM operations without resource restrictions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_088
#   severity: LOW
package lib.terraform.CB_TFAWS_088

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
	dataexfiltration := ["s3:GetObject", "ssm:GetParameter", "ssm:GetParameters", "ssm:GetParametersByPath", "ssm:GetParameter*", "secretsmanager:GetSecretValue", "*"]
	some block in input
	isvalid(block)
	some blockstatements in block.Blocks
	blockstatements.Type == "statement"
	attributes := blockstatements.Attributes
	attributes.effect == "Allow"
	some action in attributes.actions
	action in dataexfiltration
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_iam_policy_document' no data exfiltration found.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_iam_policy_document' data exfiltration should not be allowed.",
		"snippet": block,
	}
}
