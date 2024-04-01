package lib.terraform.CB_TFAWS_317

import rego.v1 

test_iam_user_member_have_user_groups if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_group_membership",
				"ok_group",
			],
			"Attributes": {
				"group": "aws_iam_group.group.name",
				"name": "tf-testing-group-membership",
				"users": "aws_iam_user.user_good.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_group",
				"group",
			],
			"Attributes": {"name": "test-group"},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 11,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user",
				"user_good",
			],
			"Attributes": {"name": "test-user"},
			"Blocks": [],
			"line_range": {
				"endLine": 17,
				"startLine": 15,
			},
		},
	]
	count(result) == 1
}

test_iam_user_member_dont_have_user_groups if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_group_membership",
				"ok_group",
			],
			"Attributes": {
				"group": "aws_iam_group.group.name",
				"name": "tf-testing-group-membership",
				"users": "aws_iam_user.user_good.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_group",
				"group",
			],
			"Attributes": {"name": "test-group"},
			"Blocks": [],
			"line_range": {
				"endLine": 13,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}
