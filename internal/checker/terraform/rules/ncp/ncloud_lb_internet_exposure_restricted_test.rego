package lib.terraform.CB_TFNCP_016

test_ncloud_lb_internet_exposure_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb",
			"example",
		],
		"Attributes": {"network_type": "PRIVATE"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ncloud_lb_internet_exposure_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"ncloud_lb",
			"example",
		],
		"Attributes": {"network_type": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
