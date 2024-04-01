# METADATA
# title: "Verify AWS Managed IAMFullAccess IAM policy is not used"
# description: "By preventing the use of the IAMFullAccess policy, the organization can better control and restrict the permissions granted to IAM principals, reducing the risk of unauthorized access and potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy.html
# custom:
#   id: CB_TFAWS_354
#   severity: HIGH
package lib.terraform.CB_TFAWS_354

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := [
		"aws_iam_role",
		"aws_iam_group_policy_attachment",
		"aws_iam_policy_attachment",
		"aws_iam_role_policy_attachment",
		"aws_iam_user_policy_attachment",
		"aws_ssoadmin_managed_policy_attachment",
	]
	label in supported_resources
}

isvalid(block) if {
	block.Type == "data"
	"aws_iam_policy" in block.Labels
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
	resource.Attributes.name == "IAMFullAccess"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	contains(resource.Attributes.arn, "IAMFullAccess")
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	contains(resource.Attributes.policy_arn, "IAMFullAccess")
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	contains(resource.Attributes.managed_policy_arn, "IAMFullAccess")
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some arn in resource.Attributes.managed_policy_arn
	contains(arn, "IAMFullAccess")
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS Managed IAMFullAccess IAM policy is not used.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS Managed IAMFullAccess IAM policy should not be used.",
		"snippet": block,
	}
}
