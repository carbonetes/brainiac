# METADATA
# title: "IAM policy documents should disallow the utilization of (*) as the action within any statement"
# description: "It is advised to avoid allowing asterisk (all resource) statements in the action elements of IAM policy documents. Allowing such broad access could lead to uncontrolled and undesired access by individuals covered by the policy."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
# custom:
#   id: CB_TFAWS_063
#   severity: HIGH
package lib.terraform.CB_TFAWS_063

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
		"message": "Using asterisk on policy documents are denied.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Using asterisk on policy documents should be denied.",
		"snippet": block,
	}
}
