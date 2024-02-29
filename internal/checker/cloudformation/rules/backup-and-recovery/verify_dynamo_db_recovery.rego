# METADATA
# title: "Verify DynamoDB point-in-time recovery (backup) is enabled"
# description: "Checks if point-in-time recovery is enabled for the DynamoDB"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html
# custom:
#   id: CB_CFT_018
#   severity: HIGH
package lib.cloudformation.CB_CFT_018

import future.keywords.in

resource := "AWS::DynamoDB::Table"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.PointInTimeRecoverySpecification
	block.PointInTimeRecoveryEnabled == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Point-in-time recovery is enabled for the DynamoDB.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Point-in-time recovery is not enabled for the DynamoDB.",
		"snippet": block,
	}
}
