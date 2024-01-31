package lib.terraform.CB_TFPAN_007

test_panos_security_policy_source_destination_add_restrict_any_passed {
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
				"destination_addresses": ["internet"],
				"source_addresses": ["trusted_network"],
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

test_panos_security_policy_source_destination_add_restrict_any_failed {
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
				"destination_addresses": [
					"internet",
					"any",
				],
				"source_addresses": [
					"trusted_network",
					"any",
				],
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
