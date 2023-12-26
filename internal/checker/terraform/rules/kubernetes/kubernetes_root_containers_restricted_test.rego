package lib.terraform.CB_TFK8S_007

test_kubernetes_root_containers_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "example"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "run_as_user",
					"Labels": [],
					"Attributes": {"rule": "MustRunAsNonRoot"},
					"Blocks": [{
						"Type": "range",
						"Labels": [],
						"Attributes": {"min": "1"},
						"Blocks": [],
						"line_range": {
							"endLine": 11,
							"startLine": 9,
						},
					}],
					"line_range": {
						"endLine": 12,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_root_containers_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "example"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "run_as_user",
					"Labels": [],
					"Attributes": {"rule": "MustRunAs"},
					"Blocks": [{
						"Type": "range",
						"Labels": [],
						"Attributes": {"min": "0"},
						"Blocks": [],
						"line_range": {
							"endLine": 11,
							"startLine": 9,
						},
					}],
					"line_range": {
						"endLine": 12,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 13,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 14,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
