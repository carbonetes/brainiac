package lib.terraform.CB_TFGCP_008

test_google_firewall_rdp_restricted {
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
		"Blocks": [
			{
				"Type": "deny",
				"Labels": [],
				"Attributes": {"protocol": "all"},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			},
			{
				"Type": "allow",
				"Labels": [],
				"Attributes": {
					"ports": ["80"],
					"protocol": "tcp",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 14,
					"startLine": 11,
				},
			},
		],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_firewall_rdp_not_restricted {
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
		"Blocks": [
			{
				"Type": "deny",
				"Labels": [],
				"Attributes": {"protocol": "all"},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 5,
				},
			},
			{
				"Type": "allow",
				"Labels": [],
				"Attributes": {
					"ports": ["3389"],
					"protocol": "tcp",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 14,
					"startLine": 11,
				},
			},
		],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
