package lib.terraform.CB_TFAWS_085
import rego.v1

test_apigateway_access_logging_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"test",
		],
		"Attributes": {"stage_name": "prod"},
		"Blocks": [{
			"Type": "access_log_settings",
			"Labels": [],
			"Attributes": {
				"destination_arn": "aws_cloudwatch_log_group.example.arn",
				"format": "...",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_apigateway_access_logging_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_api_gateway_stage",
			"test",
		],
		"Attributes": {"stage_name": "prod"},
		"Blocks": [{
			"Type": "access_log_settings",
			"Labels": [],
			"Attributes": {"format": "..."},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
