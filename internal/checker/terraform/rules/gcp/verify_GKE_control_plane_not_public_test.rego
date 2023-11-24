package lib.terraform.CB_TFGCP_037

test_gke_control_plane_not_public {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "3",
			"location": "us-central1-a",
			"name": "marcellus-wallace",
		},
		"Blocks": [{
			"Type": "master_authorized_networks_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "cidr_blocks",
				"Labels": [],
				"Attributes": {},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gke_control_plane_public {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"primary",
		],
		"Attributes": {
			"initial_node_count": "3",
			"location": "us-central1-a",
			"name": "marcellus-wallace",
		},
		"Blocks": [{
			"Type": "master_authorized_networks_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "cidr_blocks",
				"Labels": [],
				"Attributes": {"cidr_block": "0.0.0.0/0"},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			}],
			"line_range": {
				"endLine": 9,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
