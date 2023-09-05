package lib.terraform.CB_TFAWS_047

test_iam_policy_attached_to_group_roles_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_iam_user_policy_attachment",
			"example_attachment",
		],
		"Attributes": {"policy_arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_iam_policy_attached_to_group_roles_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_iam_user_policy_attachment",
			"example_attachment",
		],
		"Attributes": {
			"policy_arn": "arn:aws:iam::aws:policy/AmazonS3FullAccess",
			"user": "iam-user",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
