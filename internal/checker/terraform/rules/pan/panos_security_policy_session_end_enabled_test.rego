package lib.terraform.CB_TFPAN_010

test_panos_security_policy_session_end_enabled_passed {
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
				"log_end": true,
				"name": "example-rule",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
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

test_panos_security_policy_session_end_enabled_failed {
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
				"log_end": false,
				"name": "example-rule",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
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
