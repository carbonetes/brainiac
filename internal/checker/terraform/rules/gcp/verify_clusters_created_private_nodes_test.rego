package lib.terraform.CB_TFGCP_050

test_cluster_created_with_private_node {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "private_cluster_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 3,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cluster_not_created_with_private_node {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
