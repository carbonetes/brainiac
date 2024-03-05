# METADATA
# title: "Verify IAM role allows only to specific sevices or principal assumed"
# description: "This policy outlines the function of an IAM role, akin to an IAM user, possessing specific permissions within AWS. When a user assumes this role, they obtain temporary security credentials for a set session. It's essential to restrict the list of entities authorized to assume this role, excluding * which allows any authenticated entity across AWS to do so. We recommend creating precise roles tailored to individual services or entities. For example, when configuring an AWS service role, grant only the necessary permissions for accessing required AWS resources. Alternatively, using a principal as an entity capable of action and resource access helps minimize wildcard usage in policy documents, bolstering security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html
# custom:
#   id: CB_CFT_47
#   severity: HIGH
package lib.cloudformation.CB_CFT_47
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
