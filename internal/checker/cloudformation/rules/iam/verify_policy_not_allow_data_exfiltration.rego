# METADATA
# title: "Verify no data exfiltration for IAM policies"
# description: "This policy allows specific IAM actions, typically read-only, that lack constraints on associated resources, facilitating data exfiltration. These actions include s3:GetObject, ssm:GetParameter*, and secretsmanager:GetSecretValue."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html
# custom:
#   id: CB_CFT_080
#   severity: INFO
package lib.cloudformation.CB_CFT_080
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

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    policy := properties.PolicyDocument
    some statement in policy.Statement
    statement.Effect == "Allow"
    statement.Resource != "*"
    action_value := ["s3:GetObject", "ssm:GetParameter*", "secretsmanager:GetSecretValue"]
    some actions in statement.Action
    actions in action_value
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    deny.Resource != "*"
    action_value := ["s3:GetObject", "ssm:GetParameter*", "secretsmanager:GetSecretValue"]
    some actions in deny.Action
    actions in action_value
}


fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "No data exfiltrations in IAM policies",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policies does not allow data exfiltration",
		"snippet": block,
	}
}