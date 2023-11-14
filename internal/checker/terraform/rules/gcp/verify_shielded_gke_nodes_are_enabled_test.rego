package lib.terraform.CB_TFGCP_062

test_shielded_gke_nodes_are_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {"name": "success"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_shielded_gke_nodes_are_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {
			"enable_shielded_nodes": false,
			"name": "success",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
