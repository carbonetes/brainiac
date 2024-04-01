package lib.terraform.CB_TFAWS_343

import rego.v1 

test_ssm_secret_secured_for_untrusted_domain if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ssm_parameter",
				"param2",
			],
			"Attributes": {
				"name": "var.parameter_name",
				"type": "String",
				"value": "foo",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		}
	]
	count(result) == 1
}

test_ssm_secret_not_secured_for_untrusted_domain if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ssm_parameter",
				"param2",
			],
			"Attributes": {
				"name": "var.parameter_name",
				"type": "SecureString",
				"value": "foo",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "data",
			"Labels": [
				"http",
				"nonleak2",
			],
			"Attributes": {"url": "aws_ssm_parameter.param2.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}
