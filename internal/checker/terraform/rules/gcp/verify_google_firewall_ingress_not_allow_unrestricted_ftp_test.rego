package lib.terraform.CB_TFGCP_069

test_google_firewall_ingress_not_allow_unrestricted_ftp_access {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_firewall",
			"restricted",
		],
		"Attributes": {
			"name": "example",
			"network": "google_compute_network.vpc.name",
			"source_ranges": ["200.0.0.0/0"],
			"target_tags": ["ftp"],
		},
		"Blocks": [{
			"Type": "allow",
			"Labels": [],
			"Attributes": {
				"ports": ["21"],
				"protocol": "tcp",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_firewall_ingress_allow_unrestricted_ftp_access {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_firewall",
			"restricted",
		],
		"Attributes": {
			"name": "example",
			"network": "google_compute_network.vpc.name",
			"source_ranges": ["0.0.0.0/0"],
			"target_tags": ["ftp"],
		},
		"Blocks": [{
			"Type": "allow",
			"Labels": [],
			"Attributes": {
				"ports": ["21"],
				"protocol": "tcp",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
