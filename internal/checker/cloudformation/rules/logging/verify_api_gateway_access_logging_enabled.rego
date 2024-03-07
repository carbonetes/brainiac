# METADATA
# title: "Verify API Gateway Stage has Access Logging enabled"
# description: "Checks whether API Gateway Stage has Access Logging enabled."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html
# custom:
#   id: CB_CFT_060
#   severity: LOW
package lib.cloudformation.CB_CFT_060

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
	"DestinationArn" in object.keys(block.AccessLogSetting)
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "API Gateway Stage has access logging enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API Gateway Stage does not have access logging enabled.",
		"snippet": block,
	}
}
