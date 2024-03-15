# METADATA
# title: "Verify privilege escalation for IAM policies is not allowed"
# description: "This policy addresses various security risks associated with AWS IAM actions. It covers actions like CreateAccessKey for creating access keys for other users and AttachUserPolicy for attaching policies to users. It also considers scenarios involving privilege escalation using AWS services such as Glue, Lambda, Data Pipeline, and CloudFormation. Overall, this policy aims to enhance security by identifying and mitigating potential vulnerabilities."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html
# custom:
#   id: CB_CFT_082
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_082

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

deny_policy(deny){
    some block in deny.Statement
    block.Effect == "Allow"
    block.Resource == "*"
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some policy in properties.Policies
    statement := policy.PolicyDocument
    some deny in statement.Statement
    deny.Effect == "Allow"
    some actions in deny.Action
    actions in cloudformation.escalation
}

fail[properties] {  
    some resource in input.Resources
    properties := resource.Properties
    policy := properties.PolicyDocument
    some statement in policy.Statement
    statement.Effect == "Allow"
    some actions in statement.Action
    actions in cloudformation.escalation
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "IAM policies privilege escalation is not allowed",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "IAM policies is not allowing privilege escalation",
		"snippet": block,
	}
}