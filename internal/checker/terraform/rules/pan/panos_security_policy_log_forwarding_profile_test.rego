package lib.terraform.CB_TFPAN_009

test_panos_security_policy_log_forwarding_profile_passed {
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
				"log_setting": "example-log-forwarding-profile",
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

test_panos_security_policy_log_forwarding_profile_failed {
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
			"Attributes": {"name": "example-rule"},
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
