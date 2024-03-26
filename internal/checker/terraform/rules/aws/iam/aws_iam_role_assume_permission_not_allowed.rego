# METADATA
# title: "Make that the AWS IAM policy prohibits the assumption of roles for all services"
# description: "Detailed roles must be specified for particular services or guiding concepts."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_064
#   severity: HIGH
package lib.terraform.CB_TFAWS_064

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_role"
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
	policystr := block.Attributes.assume_role_policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect == "Allow"
	accountpattern := "^(\\d{12}|arn:aws:iam::\\d{12}:root)$"
	regex.match(accountpattern, statement.Principal.AWS)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Role permission on all services is denied.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Role permission on all services should be denied.",
		"snippet": block,
	}
}