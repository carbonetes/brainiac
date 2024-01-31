package lib.terraform.CB_TFPAN_012

test_panos_ipsec_crypto_profile_insecure_authentication_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example_profile",
		],
		"Attributes": {
			"authentications": ["sha512"],
			"name": "example_profile",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 4,
		},
	}]
	count(result) == 1
}

test_panos_ipsec_crypto_profile_insecure_authentication_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_ipsec_crypto_profile",
			"example_profile",
		],
		"Attributes": {
			"authentications": ["sha1"],
			"name": "example_profile",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 12,
			"startLine": 4,
		},
	}]
	count(result) == 1
}
