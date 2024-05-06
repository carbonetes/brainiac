package lib.terraform.CB_TFAWS_338

import rego.v1 

test_aws_backup_selection_ebs_added_in_backup_plans_of_aws_backup_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ebs_volume",
				"ebs_good",
			],
			"Attributes": {
				"availability_zone": "us-west-2a",
				"size": "40",
				"tags": {"Name": "HelloWorld"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"backup_good",
			],
			"Attributes": {
				"iam_role_arn": "arn",
				"name": "tf_example_backup_selection",
				"plan_id": "123456",
				"resources": ["aws_ebs_volume.ebs_good.arn"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 19,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}

test_aws_backup_selection_ebs_added_in_backup_plans_of_aws_backup_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ebs_volume",
				"ebs_good",
			],
			"Attributes": {
				"availability_zone": "us-west-2a",
				"size": "40",
				"tags": {"Name": "HelloWorld"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"backup_good",
			],
			"Attributes": {
				"iam_role_arn": "arn",
				"name": "tf_example_backup_selection",
				"plan_id": "123456",
				"resources": [""],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 19,
				"startLine": 11,
			},
		},
	]
	count(result) == 1
}
