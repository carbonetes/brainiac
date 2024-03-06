package lib.cloudformation.CB_CFT_075

test_access_logging_enabled_api_gateway_v2 {
	passed := {"Resources": {"MyApiGatewayStage": {
		"Properties": {"AccessLogSettings": {"DestinationArn": "arn:aws:logs:us-east-1:123456789:log-group:my-log-group"}},
		"Type": "AWS::ApiGatewayV2::Stage",
	}}}
	count(passed) == 1
}

test_access_logging_disabled_api_gateway_v2 {
	failed := {"Resources": {"MyApiGatewayStage": {
		"Properties": {"AccessLogSettings": {"DestinationArn": "arn:aws:logs::log-group:"}},
		"Type": "AWS::ApiGatewayV2::Stage",
	}}}
	count(failed) == 1
}
