package lib.terraform.CB_TFGCP_040

test_master_authorized_network_enabled_in_gke {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {"name": "marcellus-wallace"},
		"Blocks": [{
			"Type": "master_authorized_networks_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "cidr_blocks",
				"Labels": [],
				"Attributes": {
					"cidr_block": "0.0.0.0/0",
					"display_name": "test",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 5,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_master_authorized_network_not_enabled_in_gke {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {"name": "marcellus-wallace"},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
