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

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudwatch_metric_alarm"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource] {
	resource := input[_]
	resource.Attributes.actions_enabled == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CloudWatch alarm actions are enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ElasticCloudWatch alarm actions should be enabled.",
                "snippet": block }
} 