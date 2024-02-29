# METADATA
# title: "Verify IAM policies attached only to groups or roles"
# description: "IAM users, groups, and roles lack access to AWS resources by default. Privileges are granted through IAM policies, which streamline access management by assigning privileges at the group or role level. This approach minimizes complexity, especially with a growing user base, and helps prevent unintended privilege escalation. We advise applying IAM policies directly to groups and roles rather than individual users."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html
# custom:
#   id: CB_CFT_31
#   severity: LOW
package lib.cloudformation.CB_CFT_31
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
	some statements in properties.Users
	statements == ""
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policy attached succesfully",
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