# METADATA
# title: "Verify AWS AppSync has Logging enabled"
# description: "Checks if AWS AppSync has logging enabled."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-appsync-graphqlapi.html
# custom:
#   id: CB_CFT_116
#   severity: LOW
package lib.cloudformation.CB_CFT_116

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