package lib.terraform.CB_TFPAN_008

test_panos_security_policy_contains_security_policies_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_security_policy",
			"example",
		],
		"Attributes": {
			"description": "This is an example policy",
			"name": "example-policy",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 3,
		},
	}]
	count(result) == 1
}

test_panos_security_policy_contains_security_policies_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"panos_security_policy",
			"example",
		],
		"Attributes": {"name": "example-policy"},
		"Blocks": [],
		"line_range": {
			"endLine": 7,
			"startLine": 3,
		},
	}]
	count(result) == 1
}
