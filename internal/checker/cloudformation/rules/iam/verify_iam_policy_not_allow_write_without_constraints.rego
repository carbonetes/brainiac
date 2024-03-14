# METADATA
# title: "Verify write access for IAM policies is not allowed without constraints"
# description: "This policy grants permissions for actions capable of modifying resource-based policies or potentially exposing AWS resources to the public. Such actions have the potential to inadvertently reveal resources through similar operations, thus posing a risk of resource exposure."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html
# custom:
#   id: CB_CFT_083
#   severity: LOW
package lib.cloudformation.CB_CFT_083

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
    actions in cloudformation.exposures
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    some actions in deny.Action
    actions in cloudformation.exposures
}


pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policies does not allowed write access",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policies is not allowing write access",
		"snippet": block,
	}
}