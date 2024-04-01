package lib.terraform.CB_TFAWS_351

import rego.v1 

test_aws_backup_selection_ensure_efs_file_systems_are_added_in_backup_plans_of_aws_backup_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_plan",
				"example",
			],
			"Attributes": {"name": "tf_example_backup_plan"},
			"Blocks": [
				{
					"Type": "rule",
					"Labels": [],
					"Attributes": {
						"rule_name": "tf_example_backup_rule",
						"schedule": "cron(0 12 * * ? *)",
						"target_vault_name": "aws_backup_vault.test.name",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 8,
						"startLine": 4,
					},
				},
				{
					"Type": "advanced_backup_setting",
					"Labels": [],
					"Attributes": {
						"backup_options": {"WindowsVSS": "enabled"},
						"resource_type": "EC2",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 15,
						"startLine": 10,
					},
				},
			],
			"line_range": {
				"endLine": 16,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"ok_backup",
			],
			"Attributes": {
				"iam_role_arn": "aws_iam_role.example.arn",
				"name": "tf_example_backup_selection",
				"plan_id": "aws_backup_plan.example.id",
				"resources": ["aws_efs_file_system.ok_efs.arn"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 28,
				"startLine": 18,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_efs_file_system",
				"ok_efs",
			],
			"Attributes": {
				"creation_token": "my-product",
				"tags": {"Name": "MyProduct"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 36,
				"startLine": 30,
			},
		},
	]
	count(result) == 1
}

test_aws_backup_selection_ensure_efs_file_systems_are_added_in_backup_plans_of_aws_backup_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_plan",
				"example",
			],
			"Attributes": {"name": "tf_example_backup_plan"},
			"Blocks": [
				{
					"Type": "rule",
					"Labels": [],
					"Attributes": {
						"rule_name": "tf_example_backup_rule",
						"schedule": "cron(0 12 * * ? *)",
						"target_vault_name": "aws_backup_vault.test.name",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 8,
						"startLine": 4,
					},
				},
				{
					"Type": "advanced_backup_setting",
					"Labels": [],
					"Attributes": {
						"backup_options": {"WindowsVSS": "enabled"},
						"resource_type": "EC2",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 15,
						"startLine": 10,
					},
				},
			],
			"line_range": {
				"endLine": 16,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"ok_backup",
			],
			"Attributes": {
				"iam_role_arn": "aws_iam_role.example.arn",
				"name": "tf_example_backup_selection",
				"plan_id": "aws_backup_plan.example.id",
				"resources": [""],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 28,
				"startLine": 18,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_efs_file_system",
				"ok_efs",
			],
			"Attributes": {
				"creation_token": "my-product",
				"tags": {"Name": "MyProduct"},
			},
			"Blocks": [],
			"line_range": {
				"endLine": 36,
				"startLine": 30,
			},
		},
	]
	count(result) == 1
}
