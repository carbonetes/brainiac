package lib.terraform.CB_TFK8S_040

test_kubernetes_deployment_read_only_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"example_pod",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "sample-pod"},
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
					"Type": "containers",
					"Labels": [],
					"Attributes": {
						"image": "nginx:latest",
						"name": "sample-container",
					},
					"Blocks": [{
						"Type": "securityContext",
						"Labels": [],
						"Attributes": {"readOnlyRootFilesystem": true},
						"Blocks": [],
						"line_range": {
							"endLine": 12,
							"startLine": 10,
						},
					}],
					"line_range": {
						"endLine": 13,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 14,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_read_only_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"example_pod",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "sample-pod"},
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
					"Type": "containers",
					"Labels": [],
					"Attributes": {
						"image": "nginx:latest",
						"name": "sample-container",
					},
					"Blocks": [{
						"Type": "securityContext",
						"Labels": [],
						"Attributes": {"readOnlyRootFilesystem": false},
						"Blocks": [],
						"line_range": {
							"endLine": 12,
							"startLine": 10,
						},
					}],
					"line_range": {
						"endLine": 13,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 14,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
