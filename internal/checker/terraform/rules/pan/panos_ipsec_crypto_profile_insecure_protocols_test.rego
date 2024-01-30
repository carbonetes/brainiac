package lib.terraform.CB_TFPAN_013

test_panos_ipsec_crypto_profile_insecure_protocols_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example",
		],
		"Attributes": {
			"name": "example-profile",
			"protocol": "esp",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_panos_ipsec_crypto_profile_insecure_protocols_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example",
		],
		"Attributes": {
			"name": "example-profile",
			"protocol": "ah",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
