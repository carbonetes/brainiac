package lib.terraform.CB_TFGCP_073

test_private_google_access_enabled_ipv6 {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_subnetwork",
			"pass_bidi",
		],
		"Attributes": {
			"name": "log-test-subnetwork",
			"private_ip_google_access": true,
			"private_ipv6_google_access": "ENABLE_BIDIRECTIONAL_ACCESS_TO_GOOGLE",
			"stack_type": "IPV4_IPV6",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_private_google_access_not_enabled_ipv6 {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_subnetwork",
			"pass_bidi",
		],
		"Attributes": {
			"name": "log-test-subnetwork",
			"private_ip_google_access": true,
			"private_ipv6_google_access": "BIDIRECTIONAL_ACCESS_TO_GOOGLE",
			"stack_type": "IPV4_IPV6",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
