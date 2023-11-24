package lib.terraform.CB_TFGCP_009

test_no_https_ssl_proxy_permit_with_weak_cipher {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_ssl_policy",
			"modern-profile",
		],
		"Attributes": {
			"name": "nonprod-ssl-policy",
			"profile": "RESTRICTED",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_https_ssl_proxy_permit_with_weak_cipher {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_ssl_policy",
			"modern-profile",
		],
		"Attributes": {
			"custom_features": "TLS_RSA_WITH_AES_128_GCM_SHA256",
			"name": "nonprod-ssl-policy",
			"profile": "CUSTOM",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
