# METADATA
# title: "Verify AWS AppSync has Field-Level logs enabled"
# description: "Implementing a comprehensive logging process for AWS AppSync is crucial to identify and trace both manual and programmatic configuration changes, ensuring the detection of unauthorized modifications."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-appsync-graphqlapi.html
# custom:
#   id: CB_CFT_112
#   severity: LOW
package lib.cloudformation.CB_CFT_112

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
	values := ["ALL", "ERROR"]
	block.FieldLogLevel in values
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "AWS AppSync has field-level logs enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AWS AppSync does not have field-level logs enabled.",
		"snippet": block,
	}
}
