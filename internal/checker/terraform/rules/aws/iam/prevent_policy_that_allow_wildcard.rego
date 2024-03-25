# METADATA
# title: "Prevent the creation of IAM policies that grant full administrative privileges using wildcard characters for both the actions and resources."
# description: "Using wildcards for both actions and resources can lead to excessive permissions that can be exploited by attackers to gain unauthorized access to resources, escalate privileges, and cause damage to the system."
# scope: package
# related_resources:
# - https://learn.hashicorp.com/terraform/aws/iam-policy
# custom:
#   id: CB_TFAWS_001
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_001

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
	some block in input
	isvalid(block)
	some blockstatements in block.Blocks
	blockstatements.Type == "statement"
	blockstatements.Attributes.effect == "Allow"
	some action in blockstatements.Attributes.actions
	action == "*"
	some resource in blockstatements.Attributes.resources
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
		"message": "The attribute statement for actions and resources does not contain wildcard",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The attribute for actions and resources should not contain wildcard",
		"snippet": block,
	}
}
