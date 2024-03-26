# METADATA
# title: "Verify that all IAM users are members of at least one IAM group."
# description: "This practice simplifies access control, enhances security, and makes permissions management more efficient by applying permissions to groups instead of individual users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership.html
# custom:
#   id: CB_TFAWS_317
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_317

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_group_membership"
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

is_iam_user_exist if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_iam_user"
}

is_iam_group_exist if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_iam_group"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_iam_user_exist
	is_iam_group_exist
	has_attribute(resource.Attributes, "users")
	has_attribute(resource.Attributes, "group")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "All IAM users are members of at least one IAM group.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "All IAM users must be member of at least one IAM group.",
		"snippet": block,
	}
}
