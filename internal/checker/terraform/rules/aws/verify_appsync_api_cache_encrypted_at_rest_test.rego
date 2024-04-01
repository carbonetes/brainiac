package lib.terraform.CB_TFAWS_200
import rego.v1

test_appsync_api_cache_encrypted if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appsync_api_cache",
			"pass",
		],
		"Attributes": {"at_rest_encryption_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_appsync_api_cache_not_encrypted if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appsync_api_cache",
			"pass",
		],
		"Attributes": {"at_rest_encryption_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
