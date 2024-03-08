# METADATA
# title: "Verify logging enabled in DocumentDB."
# description: "Ensure logging is enabled for AWS DocumentDB clusters by verifying the presence of relevant log types such as audit and profiler."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbcluster.html
# custom:
#   id: CB_CFT_066
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_066
import future.keywords.in

resource := "AWS::DocDB::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	enabled_log := ["audit", "profiler"]
    block := resources.Properties
    some enabled in block.EnableCloudwatchLogsExports
    enabled in enabled_log
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DocumentDB logging is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DocumentDb logging is disabled",
		"snippet": block,
	}
}
