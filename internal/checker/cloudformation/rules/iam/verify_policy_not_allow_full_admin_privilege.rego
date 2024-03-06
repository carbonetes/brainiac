# METADATA
# title: "Verify IAM policy does not allow full admin privilege"
# description: "This policy should grant minimal permissions initially, adding more as needed rather than giving full administrative privileges unnecessarily, which could lead to unintended actions on resources."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-group.html
# custom:
#   id: CB_CFT_49
#   severity: HIGH
package lib.cloudformation.CB_CFT_49
import future.keywords.in

resource := "AWS::IAM::Group"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    deny.Resource == "*"
    some actions in deny.Action
    actions == "*"
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policy does not allowed admin full privilege",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policy should not allow admin full privilege",
		"snippet": block,
	}
}