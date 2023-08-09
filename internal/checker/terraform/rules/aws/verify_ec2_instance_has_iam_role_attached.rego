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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_instance"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.iam_instance_profile
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "IAM role is attached to EC2 instance.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "IAM role is not attached to EC2 instance.",
		"snippet": block,
	}
}
