package lib.terraform.CB_TFPAN_005

test_panos_security_policy_apps_any_restricted_passed {
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
				"action": "allow",
				"applications": [
					"ssh",
					"http",
				],
				"name": "example-rule",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_panos_security_policy_apps_any_restricted_failed {
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
				"action": "allow",
				"applications": [
					"ssh",
					"http",
					"any",
				],
				"name": "example-rule",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 8,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
