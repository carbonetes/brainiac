# METADATA
# title: "Verify that CloudWatch Logs are connected with CloudTrail trails"
# description: "By transferring CloudTrail logs to CloudWatch logs, you can create alarms and notifications for unusual or confidential account activity, as well as real-time and historical activity recording centered around user, API, resource, and IP address."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_339
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_339

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudtrail"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawscloudwatchloggroup contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_cloudwatch_log_group" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_cloudtrail" in resource.Labels
	some label in getthelabelforawscloudwatchloggroup
	contains(resource.Attributes.cloud_watch_logs_group_arn, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The CloudWatch Logs are connected with CloudTrail trails.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The CloudWatch Logs must be connected with CloudTrail trails.",
		"snippet": block,
	}
}
