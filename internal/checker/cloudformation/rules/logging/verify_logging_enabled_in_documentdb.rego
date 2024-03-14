# METADATA
# title: "Verify logging are enabled in DocumentDB"
# description: "This policy states that AWS DocumentDB audit logs track authentication attempts and database actions. AWS CloudWatch logs gather this data, including authentication, authorization, and user management events, for analysis, monitoring, and compliance purposes."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbcluster.html
# custom:
#   id: CB_CFT_061
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_061
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
