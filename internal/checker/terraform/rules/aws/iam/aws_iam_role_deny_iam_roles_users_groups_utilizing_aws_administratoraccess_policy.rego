# METADATA
# title: "Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups"
# description: "This policy aims to prevent IAM roles, users, and groups from employing the AdministratorAccess policy in AWS, which grants extensive permissions and should be carefully controlled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_250
#   severity: HIGH
package lib.terraform.CB_TFAWS_250

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_iam_role", "aws_iam_group_policy_attachment", "aws_iam_policy_attachment", "aws_iam_role_policy_attachment", "aws_iam_user_policy_attachment", "aws_ssoadmin_managed_policy_attachment"]
	label in supported_resources
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
	managed_policy_arns := resource.Attributes.managed_policy_arns
	ends_with_admin_access(managed_policy_arns)
}

ends_with_admin_access(arns) if {
	some arn in arns
	regex.match(`.+/AdministratorAccess$`, arn)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Utilizing AWS AdministratorAccess policy is denied for IAM roles, users, and groups.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Utilizing AWS AdministratorAccess policy must be denied for IAM roles, users, and groups.",
		"snippet": block,
	}
}
