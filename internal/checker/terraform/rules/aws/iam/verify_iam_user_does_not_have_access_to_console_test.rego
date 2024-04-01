package lib.terraform.CB_TFAWS_318

import rego.v1

test_iam_user_does_not_have_access_to_console if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user",
				"pass",
			],
			"Attributes": {"name": "tech-user"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user_login_profile",
				"pass",
			],
			"Attributes": {"user": "aws_iam_user.fail.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}

test_iam_user_have_access_to_console if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user",
				"pass",
			],
			"Attributes": {"name": "tech-user"},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user_login_profile",
				"fail",
			],
			"Attributes": {"user": "aws_iam_user.pass.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		},
	]
	count(result) == 1
}
