package lib.terraform.CB_TFGCP_085

test_pubsub_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_pubsub_topic",
			"pass",
		],
		"Attributes": {
			"kms_key_name": "google_kms_crypto_key.crypto_key.id",
			"name": "example",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_pubsub_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_pubsub_topic",
			"pass",
		],
		"Attributes": {"name": "example"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
