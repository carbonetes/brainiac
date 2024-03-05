package lib.terraform.CB_TFPAN_004

test_panos_security_policy_dsri_disabled_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_security_policy",
			"example",
		],
		"Attributes": {"name": "example-policy"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"disable_server_response_inspection": false,
				"name": "example-rule",
			},
			"Blocks": [],
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

test_panos_security_policy_dsri_disabled_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_security_policy",
			"example",
		],
		"Attributes": {"name": "example-policy"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"disable_server_response_inspection": true,
				"name": "example-rule",
			},
			"Blocks": [],
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
