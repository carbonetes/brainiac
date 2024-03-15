# METADATA
# title: "Verify Neptune logging are enabled"
# description: "This policy allows analysis of traffic patterns and troubleshooting of security and operational issues. It's advised to set your cluster to export logs to AWS CloudWatch."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-neptune-dbcluster.html
# custom:
#   id: CB_CFT_075
#   severity: HIGH
package lib.cloudformation.CB_CFT_075
import future.keywords.in

resource := "AWS::Neptune::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	some enable in properties.EnableCloudwatchLogsExports
    enable == "audit"
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Neptune logging is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Neptune logging is not enabled",
		"snippet": block,
	}
}
