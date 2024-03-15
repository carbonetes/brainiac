# METADATA
# title: "Verify IAM role allows only to specific sevices or principal assumed"
# description: "This policy establishes IAM roles with defined permissions, similar to IAM users. It restricts the list of principals able to assume a role, discouraging the use of *. We recommend crafting precise roles for specific services or principles, minimizing wildcard usage in policy documents."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html
# custom:
#   id: CB_CFT_042
#   severity: HIGH
package lib.cloudformation.CB_CFT_042
import future.keywords.in

resource := "AWS::IAM::Role"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties.AssumeRolePolicyDocument
    some statement in properties.Statement
    statement.Effect == "Deny"
    some aws_value in statement.Principal.AWS
    aws_value == "*"
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM role allowed specific services or principals",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM role allows only to specific services or principals",
		"snippet": block,
	}
}
