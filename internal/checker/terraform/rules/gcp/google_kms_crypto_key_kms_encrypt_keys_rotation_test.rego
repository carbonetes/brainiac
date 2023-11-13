package lib.terraform.CB_TFGCP_056

test_google_kms_crypto_key_kms_encrypt_keys_rotation_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key",
			"key",
		],
		"Attributes": {
			"key_ring": "google_kms_key_ring.keyring.id",
			"name": "crypto-key-example",
			"rotation_period": "7776000s",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_kms_crypto_key_kms_encrypt_keys_rotation_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key",
			"key",
		],
		"Attributes": {
			"key_ring": "google_kms_key_ring.keyring.id",
			"name": "crypto-key-example",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
