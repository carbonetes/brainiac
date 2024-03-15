# METADATA
# title: "Verify credentials for IAM policies are not exposed"
# description: "This policy concerns AWS IAM users who utilize different credentials like passwords or access keys. Certain actions, such as ecr:GetAuthorizationToken and iam:UpdateAccessKey, have the potential to expose these credentials in their API responses."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html
# custom:
#   id: CB_CFT_079
#   severity: LOW
package lib.cloudformation.CB_CFT_079

import data.lib.cloudformation
import future.keywords.in

is_valid {
	supported_resources := ["AWS::IAM::Group", "AWS::IAM::Policy", "AWS::IAM::Role", "AWS::IAM::User", "AWS::IAM::ManagedPolicy"]
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
    policy := properties.PolicyDocument
    some statement in policy.Statement
    statement.Effect == "Allow"
    some actions in statement.Action
    actions in cloudformation.exposed
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    some actions in deny.Action
    actions in cloudformation.exposed
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policies credentials are not exposed",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policies is not allowing credentials exposure",
		"snippet": block,
	}
}