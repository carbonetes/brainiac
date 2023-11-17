package lib.terraform.CB_TFGCP_091

test_data_fusion_are_private {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_data_fusion_instance",
			"pass",
		],
		"Attributes": {
			"name": "my-instance",
			"private_instance": true,
			"provider": "google-beta",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_data_fusion_are_not_private {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_data_fusion_instance",
			"pass",
		],
		"Attributes": {
			"name": "my-instance",
			"private_instance": false,
			"provider": "google-beta",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
