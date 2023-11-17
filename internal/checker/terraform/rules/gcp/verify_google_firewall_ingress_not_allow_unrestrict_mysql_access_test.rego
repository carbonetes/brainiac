package lib.terraform.CB_TFGCP_092

test_google_firewall_ingress_not_allow_unrestricted_mysql_access {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_firewall",
			"restricted",
		],
		"Attributes": {
			"name": "example",
			"network": "google_compute_network.vpc.name",
			"source_ranges": ["172.1.2.3/32"],
		},
		"Blocks": [{
			"Type": "allow",
			"Labels": [],
			"Attributes": {
				"ports": ["3306"],
				"protocol": "tcp",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_firewall_ingress_allow_unrestricted_mysql_access {
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
		},
		"Blocks": [{
			"Type": "allow",
			"Labels": [],
			"Attributes": {
				"ports": ["3306"],
				"protocol": "tcp",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
