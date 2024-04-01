package lib.terraform.CB_TFAWS_201
import rego.v1

test_appsync_api_cache_encrypted_at_transit if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appsync_api_cache",
			"pass",
		],
		"Attributes": {"transit_encryption_enabled": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_appsync_api_cache_not_encrypted_at_transit if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_appsync_api_cache",
			"pass",
		],
		"Attributes": {"transit_encryption_enabled": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
