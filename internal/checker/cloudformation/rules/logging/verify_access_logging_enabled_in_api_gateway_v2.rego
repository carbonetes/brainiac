# METADATA
# title: "Verify access logging enabled in api gateway v2"
# description: "Verify API Gateway V2 access logging for enhanced request and response monitoring."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-stage.html
# custom:
#   id: CB_CFT_070
#   severity: LOW
package lib.cloudformation.CB_CFT_070
import future.keywords.in

is_valid {
	supported_resources := ["AWS::Serverless::HttpApi", "AWS::ApiGatewayV2::Stage" ]
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

pass[log_settings] {
	is_valid
	some resources in input.Resources
	log_settings := resources.Properties.AccessLogSettings
	log_settings.DestinationArn != ""
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "API Gateway V2 enabled access logging",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "API Gateway V2 disabled access logging",
		"snippet": properties,
	}
}
