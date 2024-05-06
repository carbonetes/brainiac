package lib.terraform.CB_TFAWS_039
import rego.v1

test_sagemakernotebook_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"example",
		],
		"Attributes": {
			"kms_key_id": "test",
			"name": "my-notebook-instance",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_sagemakernotebook_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_sagemaker_notebook_instance",
			"example",
		],
		"Attributes": {"name": "my-notebook-instance"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
