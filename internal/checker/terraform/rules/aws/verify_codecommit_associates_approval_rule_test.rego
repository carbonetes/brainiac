package lib.terraform.CB_TFAWS_344

import rego.v1 

test_codecommit_associates_approval_rule if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_codecommit_repository",
				"pass",
			],
			"Attributes": {
				"description": "This is the Sample App Repository",
				"repository_name": "MyTestRepository",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_codecommit_approval_rule_template_association",
				"example",
			],
			"Attributes": {
				"approval_rule_template_name": "aws_codecommit_approval_rule_template.example.name",
				"repository_name": "aws_codecommit_repository.pass.repository_name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}

test_codecommit_not_associates_approval_rule if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_codecommit_repository",
				"pass",
			],
			"Attributes": {
				"description": "This is the Sample App Repository",
				"repository_name": "MyTestRepository",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_codecommit_approval_rule_template_association",
				"example",
			],
			"Attributes": {
				"approval_rule_template_name": "aws_codecommit_approval_rule_template.example.name",
				"repository_name": "aws_codecommit_repository.fail.repository_name",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 6,
			},
		},
	]
	count(result) == 1
}
