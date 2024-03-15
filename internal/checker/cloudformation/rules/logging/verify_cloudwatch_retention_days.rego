# METADATA
# title: "Verify Cloudwatch Log groups specify retention days"
# description: "This policy dictates how long log events are retained in AWS CloudWatch Logs. It applies retention settings to log groups, affecting all associated log streams. Data older than the retention period is automatically deleted. By default, log data persists indefinitely, potentially leading to unexpected costs. We recommend setting retention periods for log groups to manage costs and meet compliance requirements."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html
# custom:
#   id: CB_CFT_048
#   severity: LOW
package lib.cloudformation.CB_CFT_048
import future.keywords.in

resource := "AWS::Logs::LogGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	cluster := properties.RetentionInDays
    forbidden_values := ["", 0]
	not cluster in forbidden_values
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Have specified retention days",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Specify retention days",
		"snippet": block,
	}
}
