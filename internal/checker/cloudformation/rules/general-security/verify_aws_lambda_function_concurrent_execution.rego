# METADATA
# title: "Verify that AWS Lambda function is configured for function-level concurrent execution limit"
# description: "This policy enables Lambda to handle multiple simultaneous requests swiftly but may escalate costs and risk abuse. Implementing concurrency limits can mitigate sudden spikes in usage and costs, allowing adjustment of the default concurrency threshold."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# custom:
#   id: CB_CFT_084
#   severity: LOW
package lib.cloudformation.CB_CFT_084

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
	not block.ReservedConcurrentExecutions
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ReservedConcurrentExecution is configured for the AWS Lambda function.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ReservedConcurrentExecution is not configured for the AWS Lambda function.",
		"snippet": block,
	}
}
