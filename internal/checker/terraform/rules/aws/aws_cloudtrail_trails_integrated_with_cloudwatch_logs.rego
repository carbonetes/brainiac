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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelforAwsCloudwatchLogGroup[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_cloudwatch_log_group"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_cloudtrail"
    contains(resource.Attributes.cloud_watch_logs_group_arn, getTheLabelforAwsCloudwatchLogGroup[_])
}

pass[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The CloudWatch Logs are connected with CloudTrail trails.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The CloudWatch Logs must be connected with CloudTrail trails.",
                "snippet": block }
} 