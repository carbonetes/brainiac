package lib.terraform.CB_TFGCP_084

test_kms_protected_from_deletion {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key",
			"pass",
		],
		"Attributes": {"name": "crypto-example"},
		"Blocks": [{
			"Type": "lifecycle",
			"Labels": [],
			"Attributes": {"prevent_destroy": true},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kms_protected_from_deletion_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key",
			"pass",
		],
		"Attributes": {"name": "crypto-example"},
		"Blocks": [{
			"Type": "lifecycle",
			"Labels": [],
			"Attributes": {"prevent_destroy": false},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
