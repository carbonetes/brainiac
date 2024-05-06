# METADATA
# title: "Make sure that none of the IAM policies allow a statement's actions to use a wildcard."
# description: "We advise against utilizing wildcard declarations as action items. Given how the policy document is written up, this degree of access might provide anyone unwelcome and uncontrolled access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document
# custom:
#   id: CB_TFAWS_042
#   severity: HIGH
package lib.terraform.CB_TFAWS_042

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
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some blockstatements in pass
	result := {
		"message": "The attribute statement for actions does not contain wildcard",
		"snippet": blockstatements,
	}
}

failed contains result if {
	some blockstatements in fail
	result := {
		"message": "The attribute for actions should not contain wildcard",
		"snippet": blockstatements,
	}
}