# METADATA
# title: "Verify an IAM role is attached to EC2 instance"
# description: "This policy aims to ensure the proper security and access control of Amazon Elastic Compute Cloud (EC2) instances by verifying the attachment of an Identity and Access Management (IAM) role."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# custom:
#   id: CB_TFAWS_321
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_321

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_instance"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.iam_instance_profile
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "IAM role is attached to EC2 instance.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IAM role is not attached to EC2 instance.",
		"snippet": block,
	}
}
