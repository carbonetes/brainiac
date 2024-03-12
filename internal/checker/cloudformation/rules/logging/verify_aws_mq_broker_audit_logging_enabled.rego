# METADATA
# title: "Verify AWS MQ Broker Audit logging is enabled"
# description: "Ensure a reliable logging process for AWS MQBroker to track manual and programmatic configuration changes, facilitating the detection and tracing of unauthorized modifications."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html
# custom:
#   id: CB_CFT_119
#   severity: LOW
package lib.cloudformation.CB_CFT_119

import future.keywords.in

resource := "AWS::AmazonMQ::Broker"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.Configuration
	audit_logs = block.Audit
	audit_logs.Logs == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Amazon MQ Broker Audit logging is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Amazon MQ Broker Audit logging should be enabled.",
		"snippet": block,
	}
}
