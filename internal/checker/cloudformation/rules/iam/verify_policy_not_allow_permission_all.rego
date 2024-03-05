# METADATA
# title: "Verify IAM policy does not allow assumed role permission"
# description: "This policy defines permissions for an IAM role, functioning similarly to an IAM user. When a user assumes this role, it receives temporary credentials for a limited session. It's recommended to create specialized roles for specific services or principles. For example, when configuring an AWS service role, include only essential permissions for accessing required resources. Alternatively, using a Principal entity allows actions and resource access, limiting wildcard usage within policy documents."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html
# custom:
#   id: CB_CFT_48
#   severity: HIGH
package lib.cloudformation.CB_CFT_48
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
    statement.Effect == "Allow"
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
		"message": "IAM policy does not allowed assumed role permission",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policy should not allow assumed role permission",
		"snippet": block,
	}
}
