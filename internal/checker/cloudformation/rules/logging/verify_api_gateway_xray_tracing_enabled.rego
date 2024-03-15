# METADATA
# title: "Verify API Gateway has X-Ray Tracing enabled"
# description: "This policy, when active tracing is enabled for an API Gateway stage, automatically samples API invocation requests using the AWS X-Ray sampling algorithm. With tracing enabled, X-Ray provides an end-to-end view of HTTP requests, facilitating analysis of latencies in APIs and backend services."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html
# custom:
#   id: CB_CFT_053
#   severity: LOW
package lib.cloudformation.CB_CFT_053

import future.keywords.in

is_valid {
	supported_resources := ["AWS::ApiGateway::Stage", "AWS::Serverless::Api"]
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

pass[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties
	block.TracingEnabled == true
}

fail[resources] {
	is_valid
	some resources in input.Resources
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "API Gateway stage has X-Ray Tracing enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API Gateway stage does not have X-Ray Tracing enabled.",
		"snippet": block,
	}
}
