package lib.terraform.CB_TFGCP_074

test_google_firewall_ingress_not_allow_on_ftp_port {
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
				"ports": ["20"],
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

test_google_firewall_ingress_allow_on_ftp_port {
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
				"ports": ["20"],
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
