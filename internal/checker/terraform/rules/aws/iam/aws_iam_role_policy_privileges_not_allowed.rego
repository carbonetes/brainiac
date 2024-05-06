# METADATA
# title: "Aim to prevent the creation of IAM policies that grant full administrative privileges"
# description: "Users, groups, and roles are granted privileges through the use of IAM policies. It is advisable to avoid granting full administrative access, as this could expose resources to potentially undesirable behaviors."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
# custom:
#   id: CB_TFAWS_061
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_061

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_iam_group_policy", "aws_iam_policy", "aws_iam_role_policy", "aws_iam_user_policy", "aws_ssoadmin_permission_set_inline_policy"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Type == "resource"
	policystr := block.Attributes.policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect == "Allow"
	contains(statement.Action, "*")
	contains(statement.Resource, "*")
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Full administrative privileges are denied.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Full administrative privileges must be denied.",
		"snippet": block,
	}
}