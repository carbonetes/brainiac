# METADATA
# title: "Verify access logging enabled in api gateway v2"
# description: "Verify API Gateway V2 access logging for enhanced request and response monitoring."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-stage.html
# custom:
#   id: CB_CFT_075
#   severity: LOW
package lib.cloudformation.CB_CFT_075
import future.keywords.in

resource := "AWS::ApiGatewayV2::Stage"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[log_settings] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
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
