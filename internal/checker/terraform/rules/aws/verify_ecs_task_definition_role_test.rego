package lib.terraform.CB_TFAWS_281

import rego.v1 

test_verify_ecs_task_definition_role_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ecs_task_definition",
				"example"
			],
			"Attributes": {
				"execution_role_arn": "aws_iam_role.execution_role.arn",
				"task_role_arn": "aws_iam_role.task_role.arn"
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}

test_verify_ecs_task_definition_role_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_ecs_task_definition",
				"example"
			],
			"Attributes": {
				"execution_role_arn": "aws_iam_role.execution_role.arn",
				"task_role_arn": "aws_iam_role.execution_role.arn"
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1
			}
		}
	]
	count(result) == 1
}
