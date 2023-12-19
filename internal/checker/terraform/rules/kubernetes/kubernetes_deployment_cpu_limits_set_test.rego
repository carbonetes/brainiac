package lib.terraform.CB_TFK8S_014

test_kubernetes_deployment_cpu_limits_set_passed {
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
						"image": "example-image",
						"name": "example-container",
					},
					"Blocks": [{
						"Type": "resources",
						"Labels": [],
						"Attributes": {"limits": {"cpu": "1"}},
						"Blocks": [],
						"line_range": {
							"endLine": 15,
							"startLine": 11,
						},
					}],
					"line_range": {
						"endLine": 16,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 17,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_cpu_limits_set_failed {
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
						"image": "example-image",
						"name": "example-container",
					},
					"Blocks": [{
						"Type": "resources",
						"Labels": [],
						"Attributes": {},
						"Blocks": [],
						"line_range": {
							"endLine": 15,
							"startLine": 11,
						},
					}],
					"line_range": {
						"endLine": 16,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 17,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 18,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
