package lib.terraform.CB_TFAWS_282

import rego.v1 

test_ssm_documents_not_public if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ssm_document_permission",
			"example_permission",
		],
		"Attributes": {
			"account_ids": "local.allowed_account_ids",
			"document_version": "aws_ssm_document.example_document.version",
			"name": "aws_ssm_document.example_document.name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ssm_documents_public if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ssm_document_permission",
			"example_permission",
		],
		"Attributes": {
			"account_ids": "All",
			"document_version": "aws_ssm_document.example_document.version",
			"name": "aws_ssm_document.example_document.name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
