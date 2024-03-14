# METADATA
# title: "Verify IAM policy does not allow assumed role permission"
# description: "This policy establishes IAM roles, similar to IAM users, with specific permissions and AWS identity. Users assuming roles receive temporary credentials. We recommend creating precise roles for services, minimizing wildcard usage in policy documents. Alternatively, use Principal entities in AWS for actions and resource access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html
# custom:
#   id: CB_CFT_043
#   severity: HIGH
package lib.cloudformation.CB_CFT_043
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
