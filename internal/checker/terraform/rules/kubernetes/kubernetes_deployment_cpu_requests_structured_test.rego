package lib.terraform.CB_TFK8S_013

test_kubernetes_deployment_cpu_requests_structured_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
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
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "nginx",
						"name": "example-container",
					},
					"Blocks": [{
						"Type": "resources",
						"Labels": [],
						"Attributes": {"requests": {"cpu": "0.5"}},
						"Blocks": [],
						"line_range": {
							"endLine": 14,
							"startLine": 10,
						},
					}],
					"line_range": {
						"endLine": 15,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 16,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 17,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_cpu_requests_structured_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
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
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "nginx",
						"name": "example-container",
					},
					"Blocks": [{
						"Type": "resources",
						"Labels": [],
						"Attributes": {"requests": {}},
						"Blocks": [],
						"line_range": {
							"endLine": 14,
							"startLine": 10,
						},
					}],
					"line_range": {
						"endLine": 15,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 16,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 17,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
