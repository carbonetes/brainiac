# METADATA
# title: "Verify access logging enabled in api gateway v2"
# description: "Verify API Gateway V2 access logging for enhanced request and response monitoring."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-stage.html
# custom:
#   id: CB_CFT_075
#   severity: Low
package lib.cloudformation.CB_CFT_075
import future.keywords.in

resource := "AWS::ApiGatewayV2::Stage"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    destination_arn := resources.Properties.AccessLogSettings.DestinationArn
    regex_pattern = `^arn:aws:logs:[a-z0-9-]+:[0-9]+:log-group:[a-zA-Z0-9-_]+$`
    regex.match(regex_pattern, destination_arn)
    properties := resources.Properties.AccessLogSettings
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
