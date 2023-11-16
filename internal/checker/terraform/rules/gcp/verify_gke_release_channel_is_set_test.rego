package lib.terraform.CB_TFGCP_061

test_gke_release_channel_set {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "release_channel",
			"Labels": [],
			"Attributes": {"channel": "var.release_channel"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gke_release_channel_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"success",
		],
		"Attributes": {"name": "success"},
		"Blocks": [{
			"Type": "release_channel",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
