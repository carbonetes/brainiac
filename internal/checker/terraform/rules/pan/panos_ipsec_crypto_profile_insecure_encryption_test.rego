package lib.terraform.CB_TFPAN_011

test_panos_ipsec_crypto_profile_insecure_encryption_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example",
		],
		"Attributes": {
			"encryptions": [
				"aes-256-gcm",
				"aes-256-sha256",
			],
			"name": "example-profile",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 2,
		},
	}]
	count(result) == 1
}

test_panos_ipsec_crypto_profile_insecure_encryption_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example",
		],
		"Attributes": {
			"encryptions": [
				"des",
				"3des",
				"aes-128-cbc",
				"aes-192-cbc",
				"aes-256-cbc",
				"null",
			],
			"name": "example-profile",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 2,
		},
	}]
	count(result) == 1
}
