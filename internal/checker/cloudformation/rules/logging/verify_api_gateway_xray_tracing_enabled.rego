# METADATA
# title: "Verify API Gateway has X-Ray Tracing enabled"
# description: "Checks whether X-Ray Tracing is enabled for an API Gateway stage."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html
# custom:
#   id: CB_CFT_058
#   severity: LOW
package lib.cloudformation.CB_CFT_058

import future.keywords.in

resource := ["AWS::ApiGateway::Stage", "AWS::Serverless::Api"]

is_valid {
	some resources in input.Resources
	some resource_type in resource
	resources.Type == resource_type
}

pass[block] {
	is_valid
	some resources in input.Resources
	some resource_type in resource
	resources.Type == resource_type
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
