package lib.cloudformation.CB_CFT_070

test_access_logging_enabled_api_gateway_v2 {
	result := passed with input as {"Resources": {"MyApiGatewayStage": {
		"Properties": {"AccessLogSettings": {"DestinationArn": "arn:aws:logs:us-east-1:123456789:log-group:my-log-group"}},
		"Type": "AWS::ApiGatewayV2::Stage",
	}}}
	count(result) == 1
}

test_access_logging_disabled_api_gateway_v2 {
	result := failed with input as {"Resources": {"MyApiGatewayStage": {
		"Properties": {"AccessLogSettings": {"DestinationArn": ""}},
		"Type": "AWS::ApiGatewayV2::Stage",
	}}}
	count(result) == 1
}
