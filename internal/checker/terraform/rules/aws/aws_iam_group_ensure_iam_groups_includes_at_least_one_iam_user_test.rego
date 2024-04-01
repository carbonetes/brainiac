package lib.terraform.CB_TFAWS_347

import rego.v1 

test_aws_iam_group_ensure_iam_groups_includes_at_least_one_iam_user_passed if {
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
				"users": "aws_iam_user.user_one.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
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
				"endLine": 14,
				"startLine": 12,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_iam_user",
				"user_one",
			],
			"Attributes": {"name": "test-user"},
			"Blocks": [],
			"line_range": {
				"endLine": 18,
				"startLine": 16,
			},
		},
	]
	count(result) == 1
}

test_aws_iam_group_ensure_iam_groups_includes_at_least_one_iam_user_failed if {
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
				"users": "aws_iam_user.user_one.name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
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
				"endLine": 14,
				"startLine": 12,
			},
		},
	]
	count(result) == 1
}
