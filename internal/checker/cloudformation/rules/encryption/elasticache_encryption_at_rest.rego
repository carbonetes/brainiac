# METADATA
# title: "Verify all data stored in the ElastiCache Group is encrypted at rest"
# description: "Checks if all data stored in the ElastiCache Group is encrypted at rest"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticache-replicationgroup.html
# custom:
#   id: CB_CFT_019
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_019

import future.keywords.in

resource := "AWS::ElastiCache::ReplicationGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	block.AtRestEncryptionEnabled == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Encryption at rest is enabled for the ElastiCache Group.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption at rest is not enabled for the ElastiCache Group.",
		"snippet": block,
	}
}
