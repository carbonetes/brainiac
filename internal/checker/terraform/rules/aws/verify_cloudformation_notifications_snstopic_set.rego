# METADATA
# title: "Verify that CloudFormation stacks are sending event notifications to an SNS topic"
# description: " It ensures that you receive real-time updates about stack events, automate actions based on those events, gain a centralized view of stack activities, and easily integrate with other AWS services."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudformation_stack.html
# custom:
#   id: CB_TFAWS_120
#   severity: LOW
package lib.terraform.CB_TFAWS_120

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudformation_stack"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "notification_arns")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudformation_stack' are sending event notifications to an SNS topic",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudformation_stack' 'notification_arns' should be set",
		"snippet": block,
	}
}