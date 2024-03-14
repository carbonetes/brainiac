# METADATA
# title: "Verify that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
# description: "This policy allows investigation of errors or failed requests to the connected Lambda function through a DLQ or an on-failure destination target. Understanding failure reasons is vital to prevent data loss or compromise, especially with Lambda functions processing security-related data like CloudTrail events."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# custom:
#   id: CB_CFT_085
#   severity: LOW
package lib.cloudformation.CB_CFT_085

import future.keywords.in

is_valid {
	supported_resources := ["AWS::Lambda::Function", "AWS::Serverless::Function"]
	some resources in input.Resources
	resources.Type in supported_resources
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(fail) > 0
	type := resource.Type
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(pass) > 0
	type := resource.Type
}

fail[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties
	not "TargetArn" in object.keys(block.DeadLetterConfig)
}

fail[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties
	not "TargetArn" in object.keys(block.DeadLetterQueue)
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DeadLetterQueue is configured for the AWS Lambda function.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DeadLetterQueue is not configured for the AWS Lambda function.",
		"snippet": block,
	}
}
