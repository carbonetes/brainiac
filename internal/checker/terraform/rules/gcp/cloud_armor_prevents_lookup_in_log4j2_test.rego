package lib.terraform.CB_TFGCP_064

test_cloud_armor_prevents_lookup_in_log4j2 {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_security_policy",
			"example",
		],
		"Attributes": {"name": "example"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"action": "deny(403)",
				"preview": false,
				"priority": "1",
			},
			"Blocks": [{
				"Type": "match",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "expr",
					"Labels": [],
					"Attributes": {"expression": "evaluatePreconfiguredExpr('cve-canary')"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 12,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_cloud_armor_prevents_lookup_in_log4j2_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_compute_security_policy",
			"example",
		],
		"Attributes": {"name": "example"},
		"Blocks": [{
			"Type": "rule",
			"Labels": [],
			"Attributes": {
				"action": "allow",
				"preview": false,
				"priority": "1",
			},
			"Blocks": [{
				"Type": "match",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "expr",
					"Labels": [],
					"Attributes": {"expression": "evaluatePreconfiguredExpr('cve-canary')"},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 9,
					},
				}],
				"line_range": {
					"endLine": 12,
					"startLine": 8,
				},
			}],
			"line_range": {
				"endLine": 13,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
