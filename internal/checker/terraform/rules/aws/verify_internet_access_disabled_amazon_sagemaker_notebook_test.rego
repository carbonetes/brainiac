package lib.terraform.CB_TFAWS_117
import rego.v1

test_sagemaker_notebook_internet_disabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"test",
		],
		"Attributes": {
			"direct_internet_access": "Disabled",
			"instance_type": "ml.t2.medium",
			"name": "my-notebook-instance",
			"role_arn": "aws_iam_role.role.arn",
			"tags": {"Name": "foo"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_sagemaker_notebook_internet_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"test",
		],
		"Attributes": {
			"direct_internet_access": "Enabled",
			"instance_type": "ml.t2.medium",
			"name": "my-notebook-instance",
			"role_arn": "aws_iam_role.role.arn",
			"tags": {"Name": "foo"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
