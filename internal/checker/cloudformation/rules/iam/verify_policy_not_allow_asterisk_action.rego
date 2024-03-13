# METADATA
# title: "Verify IAM policy does not allow asterisk statement in action"
# description: "This policy should grant only essential permissions initially, adding more as needed, rather than providing full administrative privileges right away. Doing so exposes resources to potential unwanted actions."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-group.html
# custom:
#   id: CB_CFT_045
#   severity: HIGH
package lib.cloudformation.CB_CFT_045
import future.keywords.in

is_valid {
	supported_resources := ["AWS::IAM::Group", "AWS::IAM::Policy", "AWS::IAM::Role", "AWS::IAM::User"]
	some resources in input.Resources
	resources.Type in supported_resources
}

resource[type] {
	some resource in input.Resources
    is_valid
    count(fail) > 0
    type := resource.Type
}

resource[type] {
	some resource in input.Resources
    is_valid
    count(pass) > 0
    type := resource.Type
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    some actions in deny.Action
    actions == "*"
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    policy := properties.PolicyDocument
    some statement in policy.Statement
    statement.Effect == "Allow"
    some actions in statement.Action
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
		"message": "IAM policy does not allowed asterisk statement in action",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policy should not allow asterisk statement in action",
		"snippet": block,
	}
}