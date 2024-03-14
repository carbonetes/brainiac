# METADATA
# title: "Verify Logging for AWS AppSync is enabled"
# description: "This policy suggests implementing a comprehensive logging process for AWS AppSync. Doing so helps monitor both manual and programmatic configuration changes, facilitating the identification and tracing of unauthorized modifications."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-appsync-graphqlapi.html
# custom:
#   id: CB_CFT_111
#   severity: LOW
package lib.cloudformation.CB_CFT_111

import future.keywords.in

resource := "AWS::AppSync::GraphQLApi"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.LogConfig
	"CloudWatchLogsRoleArn" in object.keys(block)
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AWS AppSync has logging enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AWS AppSync does not have logging enabled.",
		"snippet": block,
	}
}
