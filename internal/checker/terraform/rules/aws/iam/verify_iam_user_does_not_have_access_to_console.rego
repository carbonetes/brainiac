# METADATA
# title: "Verify an IAM User does not have access to the console"
# description: "By enforcing this policy, organizations can enhance their AWS account security by restricting console access to only authorized individuals or roles, aligning with the principle of least privilege."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user.html
# custom:
#   id: CB_TFAWS_318
#   severity: HIGH
package lib.terraform.CB_TFAWS_318

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_iam_user"
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

getiamuserlabel contains label if {
	some resource in input
	resource.Type == "resource"
	some label_resource in resource.Labels
	label_resource == "aws_iam_user"
	label := concat(".", resource.Labels)
}

is_iam_user_login_is_linked if {
	some resource in input
	resource.Type == "resource"
	some label_resource in resource.Labels
	label_resource == "aws_iam_user_login_profile"
	some label in getiamuserlabel
	startswith(resource.Attributes.user, label)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_iam_user_login_is_linked
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": " IAM User does not have access to the console.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": " IAM User does should not have access to the console.",
		"snippet": block,
	}
}
