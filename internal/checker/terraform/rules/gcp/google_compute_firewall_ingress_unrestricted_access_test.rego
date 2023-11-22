package lib.terraform.CB_TFGCP_113

test_google_compute_firewall_ingress_unrestricted_access_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_firewall",
			"compute-firewall-ok-1",
		],
		"Attributes": {
			"disabled": false,
			"name": "compute-firewall-ok-1",
			"network": "google_compute_network.example.name",
			"source_ranges": ["0.0.0.0/0"],
		},
		"Blocks": [{
			"Type": "deny",
			"Labels": [],
			"Attributes": {"protocol": "all"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 2,
		},
	}]
	count(result) == 1
}

test_google_compute_firewall_ingress_unrestricted_access_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_firewall",
			"compute-firewall-ok-1",
		],
		"Attributes": {
			"disabled": false,
			"name": "compute-firewall-ok-1",
			"network": "google_compute_network.example.name",
			"source_ranges": ["0.0.0.0/0"],
		},
		"Blocks": [{
			"Type": "allow",
			"Labels": [],
			"Attributes": {"protocol": "all"},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 6,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 2,
		},
	}]
	count(result) == 1
}
