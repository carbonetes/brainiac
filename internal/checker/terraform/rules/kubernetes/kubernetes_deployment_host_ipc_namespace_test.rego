package lib.terraform.CB_TFK8S_036

test_kubernetes_deployment_host_ipc_namespace_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_deployment",
			"example_deployment",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "example-deployment"},
				"Blocks": [],
				"line_range": {
					"endLine": 15,
					"startLine": 13,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "template",
					"Labels": [],
					"Attributes": {},
					"Blocks": [{
						"Type": "spec",
						"Labels": [],
						"Attributes": {"host_ipc": false},
						"Blocks": [],
						"line_range": {
							"endLine": 22,
							"startLine": 19,
						},
					}],
					"line_range": {
						"endLine": 23,
						"startLine": 18,
					},
				}],
				"line_range": {
					"endLine": 24,
					"startLine": 17,
				},
			},
		],
		"line_range": {
			"endLine": 25,
			"startLine": 12,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_host_ipc_namespace_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_deployment",
			"example_deployment",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "example-deployment"},
				"Blocks": [],
				"line_range": {
					"endLine": 15,
					"startLine": 13,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {},
				"Blocks": [{
					"Type": "template",
					"Labels": [],
					"Attributes": {},
					"Blocks": [{
						"Type": "spec",
						"Labels": [],
						"Attributes": {"host_ipc": true},
						"Blocks": [],
						"line_range": {
							"endLine": 22,
							"startLine": 19,
						},
					}],
					"line_range": {
						"endLine": 23,
						"startLine": 18,
					},
				}],
				"line_range": {
					"endLine": 24,
					"startLine": 17,
				},
			},
		],
		"line_range": {
			"endLine": 25,
			"startLine": 12,
		},
	}]
	count(result) == 1
}
