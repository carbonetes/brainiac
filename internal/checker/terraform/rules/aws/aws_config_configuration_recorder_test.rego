package lib.terraform.CB_TFAWS_346

import rego.v1 

test_aws_config_configuration_recorder_passed if {
	result := passed with input as [
	{
		"Type": "resource",
		"Labels": [
		"aws_config_configuration_recorder",
		"pass_recorder"
		],
		"Attributes": {
		"name": "example",
		"role_arn": "aws_iam_role.r.arn"
		},
		"Blocks": [
		{
			"Type": "recording_group",
			"Labels": [],
			"Attributes": {
			"include_global_resource_types": true
			},
			"Blocks": [],
			"line_range": {
			"endLine": 7,
			"startLine": 5
			}
		}
		],
		"line_range": {
		"endLine": 9,
		"startLine": 1
		}
	}
	]
	count(result) == 1
}

test_aws_config_configuration_recorder_failed if {
	result := failed with input as [
	{
		"Type": "resource",
		"Labels": [
		"aws_config_configuration_recorder",
		"pass_recorder"
		],
		"Attributes": {
		"name": "example",
		"role_arn": "aws_iam_role.r.arn"
		},
		"Blocks": [
		{
			"Type": "recording_group",
			"Labels": [],
			"Attributes": {
			"include_global_resource_types": false
			},
			"Blocks": [],
			"line_range": {
			"endLine": 7,
			"startLine": 5
			}
		}
		],
		"line_range": {
		"endLine": 9,
		"startLine": 1
		}
	}
	]
	count(result) == 1
}