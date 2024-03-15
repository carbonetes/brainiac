# METADATA
# title: "Verify IAM policies attached only to groups or roles"
# description: "This policy dictates that IAM users, groups, and roles have no default access to AWS resources. Access privileges are granted through IAM policies. Assigning privileges at the group or role level simplifies access management, reducing the risk of inadvertent privilege escalation. It is recommended to apply IAM policies directly to groups and roles, not individual users."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html
# custom:
#   id: CB_CFT_027
#   severity: LOW
package lib.cloudformation.CB_CFT_027

import future.keywords.in

resource := "AWS::IAM::Policy"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    not "Users" in object.keys(properties)
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policies attached only to groups or roles",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policy can only attached to groups or roles",
		"snippet": block,
	}
}
