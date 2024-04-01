package lib.terraform.CB_TFAWS_288

import rego.v1

test_sagemakernotebook_launch_custom_vpc if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"example_notebook_instance",
		],
		"Attributes": {
			"instance_type": "ml.t2.medium",
			"name": "example-notebook-instance",
			"role_arn": "arn:aws:iam::123456789012:role/sagemaker-notebook-role",
			"root_access": "Disabled",
			"security_groups": "aws_security_group.example_security_group.id",
			"subnet_id": "aws_subnet.example_subnet.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_sagemakernotebook_not_launch_custom_vpc if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"example_notebook_instance",
		],
		"Attributes": {
			"instance_type": "ml.t2.medium",
			"name": "example-notebook-instance",
			"role_arn": "arn:aws:iam::123456789012:role/sagemaker-notebook-role",
			"root_access": "Disabled",
			"security_groups": "aws_security_group.example_security_group.id",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
