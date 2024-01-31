package lib.terraform.CB_TFPAN_002

test_panos_management_profile_http_disabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_management_profile",
			"example",
		],
		"Attributes": {"name": "example-profile"},
		"Blocks": [{
			"Type": "http",
			"Labels": [],
			"Attributes": {"enable": false},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_panos_management_profile_http_disabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_management_profile",
			"example",
		],
		"Attributes": {"name": "example-profile"},
		"Blocks": [{
			"Type": "http",
			"Labels": [],
			"Attributes": {"enable": true},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
