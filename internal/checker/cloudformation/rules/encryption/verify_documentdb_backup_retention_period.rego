# METADATA
# title: "Verify DocumentDB has an adequate backup retention period"
# description: "Checks if AWS DocumentDB maintains a sufficient backup retention period, this is crucial for effective data protection and recovery strategies."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbcluster.html
# custom:
#   id: CB_CFT_118
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_118

import future.keywords.in

resource := "AWS::DocDB::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	block.BackupRetentionPeriod >= 7
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DocumentDB has an adequate backup retention period.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DocumentDB should have an adequate backup retention period.",
		"snippet": block,
	}
}
