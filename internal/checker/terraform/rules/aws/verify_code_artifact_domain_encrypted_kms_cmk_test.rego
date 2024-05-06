package lib.terraform.CB_TFAWS_212
import rego.v1

test_code_artifact_domain_is_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codeartifact_domain",
			"pass",
		],
		"Attributes": {
			"domain": "example",
			"encryption_key": "aws_kms_key.example.arn",
			"tags": {"key": "value"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_code_artifact_domain_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_codeartifact_domain",
			"pass",
		],
		"Attributes": {
			"domain": "example",
			"tags": {"key": "value"},
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
