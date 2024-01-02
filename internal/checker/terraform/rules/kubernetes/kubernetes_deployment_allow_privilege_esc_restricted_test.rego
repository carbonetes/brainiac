package lib.terraform.CB_TFK8S_043

test_kubernetes_deployment_allow_privilege_esc_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"<Pod name>",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "Pod name"},
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
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "image",
						"name": "container name",
					},
					"Blocks": [{
						"Type": "security_context",
						"Labels": [],
						"Attributes": {"allow_privilege_escalation": false},
						"Blocks": [],
						"line_range": {
							"endLine": 13,
							"startLine": 11,
						},
					}],
					"line_range": {
						"endLine": 14,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 15,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_allow_privilege_esc_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"<Pod name>",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "Pod name"},
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
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "image",
						"name": "container name",
					},
					"Blocks": [{
						"Type": "security_context",
						"Labels": [],
						"Attributes": {"allow_privilege_escalation": true},
						"Blocks": [],
						"line_range": {
							"endLine": 13,
							"startLine": 11,
						},
					}],
					"line_range": {
						"endLine": 14,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 15,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 16,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
