# METADATA
# title: "Verify SQS policy does not allow ALL (*) actions."
# description: "By explicitly defining the allowed actions in the policy, the risk of unauthorized access and unintended operations on SQS queues is minimized."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy
# custom:
#   id: CB_TFAWS_079
#   severity: HIGH
package lib.terraform.CB_TFAWS_079

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sqs_queue_policy"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

allowAllAction(statement) if {
	some actions in statement.Action
	actions == "*"
}

allowAllAction(statement) if {
	statement.Action == "*"
}

fail contains block if {
	some block in input
	isvalid(block)
	policystr := block.Attributes.policy
	policyparsed := json.unmarshal(policystr)
	statement := policyparsed.Statement[0]
	statement.Effect == "Allow"
	allowAllAction(statement)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SQS policy does not allow ALL (*) actions.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "SQS policy should not allow ALL (*) actions.",
		"snippet": block,
	}
}