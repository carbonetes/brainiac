# METADATA
# title: "Verify that the IAM role permits exclusive authorization for designated services or principals to assume its privileges"
# description: "Restrict the list of allowed principals to assume a role, avoiding the use of wildcard (*) which grants access to any authenticated identity in AWS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_058
#   severity: HIGH
package lib.terraform.CB_TFAWS_058

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
	block.Type == "resource"
	policystr := block.Attributes.assume_role_policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect == "Allow"
	contains(statement.Principal.AWS, "*")
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "No wildcard is used in the Principal.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Wildcard should not  be used in the Principal.",
		"snippet": block,
	}
}
