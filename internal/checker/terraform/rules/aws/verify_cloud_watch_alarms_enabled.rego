# METADATA
# title: "Verify that CloudWatch alarm actions are enabled"
# description: "By enabling the `actions_enabled` property and configuring CloudWatch alarm actions, timely notifications and automated responses can be triggered, ensuring proactive monitoring and mitigation of critical issues in AWS infrastructure, leading to improved system reliability and minimized downtime."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm
# custom:
#   id: CB_TFAWS_307
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_307

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudwatch_metric_alarm"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	resource.Attributes.actions_enabled == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CloudWatch alarm actions are enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ElasticCloudWatch alarm actions should be enabled.",
		"snippet": block,
	}
}
