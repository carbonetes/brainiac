# METADATA
# title: "Verify point-in-time recovery (backup) for DynamoDB is enabled"
# description: "This policy entails DynamoDB Point-In-Time Recovery (PITR), an automatic backup service for DynamoDB tables. It guards against accidental write or delete operations by providing continuous backups and allowing restoration of table data from any point within the last 35 days, including incremental backups."
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
