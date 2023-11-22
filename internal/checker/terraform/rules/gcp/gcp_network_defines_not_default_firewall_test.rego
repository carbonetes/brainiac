package lib.terraform.CB_TFGCP_128

test_gcp_network_defines_a_not_default_firewall {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_compute_network",
				"example_network",
			],
			"Attributes": {
				"auto_create_subnetworks": false,
				"name": "example-network",
				"project": "<your-gcp-project-id>",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_compute_firewall",
				"example_firewall",
			],
			"Attributes": {
				"name": "example-firewall",
				"network": "google_compute_network.example_network.name",
				"project": "<your-gcp-project-id>",
			},
			"Blocks": [{
				"Type": "allow",
				"Labels": [],
				"Attributes": {
					"ports": ["22"],
					"protocol": "tcp",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 17,
					"startLine": 14,
				},
			}],
			"line_range": {
				"endLine": 18,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}

test_gcp_network_defines_a_not_default_firewall_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_network",
			"example_network",
		],
		"Attributes": {
			"auto_create_subnetworks": false,
			"name": "example-network",
			"project": "<your-gcp-project-id>",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
