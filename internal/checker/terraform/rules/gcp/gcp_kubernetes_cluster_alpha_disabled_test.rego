package lib.terraform.CB_TFGCP_127

test_kubernetes_cluster_alpha_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example_cluster",
		],
		"Attributes": {
			"enable_kubernetes_alpha": false,
			"name": "example-cluster",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_cluster_alpha_disabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example_cluster",
		],
		"Attributes": {
			"enable_kubernetes_alpha": true,
			"name": "example-cluster",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
