# METADATA
# title: "Verify point-in-time recovery (backup) is enabled for the DynamoDB global table."
# description: "This policy enables point-in-time recovery (PITR) for Amazon DynamoDB global tables, safeguarding against data loss from accidental operations or corruption. It allows restoration to any point within a 35-day recovery window, aiding in undoing unintended changes or recovering from corruption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-globaltable.html
# custom:
#   id: CB_CFT_104
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_104
import future.keywords.in

resource := "AWS::DynamoDB::GlobalTable"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    some resource in input.Resources
    properties := resource.Properties
    some replica in properties.Replicas
    replica.PointInTimeRecoverySpecification.PointInTimeRecoveryEnabled == false
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DynamoDB global table in time recovery (backup) is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DynamoDB global table in time recovery (backup) is not enabled.",
		"snippet": block,
	}
}