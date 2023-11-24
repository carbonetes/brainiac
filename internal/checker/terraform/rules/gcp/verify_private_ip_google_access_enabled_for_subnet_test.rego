package lib.terraform.CB_TFGCP_068

test_private_ip_google_access_enabled_for_subnet {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_subnetwork",
			"pass",
		],
		"Attributes": {
			"name": "example",
			"private_ip_google_access": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_private_ip_google_access_enabled_for_subnet_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_subnetwork",
			"pass",
		],
		"Attributes": {
			"name": "example",
			"private_ip_google_access": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
