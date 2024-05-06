# METADATA
# title: "Verify that  IAM policies are attached only to groups, roles to avoid privilege escalation"
# description: "IAM policies are attached only to groups, roles to avoid privilege escalation"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy
# custom:
#   id: CB_TFAWS_047
#   severity: LOW
package lib.terraform.CB_TFAWS_047

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_iam_user_policy_attachment", "aws_iam_user_policy", "aws_iam_policy_attachment"]
	label in supportedresource
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

fail contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "user")
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_iam_user_policy_attachment', 'aws_iam_user_policy', 'aws_iam_policy_attachment' 'user' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_iam_user_policy_attachment', 'aws_iam_user_policy', 'aws_iam_policy_attachment' 'user' is not set properly.",
		"snippet": block,
	}
}