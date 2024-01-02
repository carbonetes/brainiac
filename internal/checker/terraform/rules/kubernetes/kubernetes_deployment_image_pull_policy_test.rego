package lib.terraform.CB_TFK8S_042

test_kubernetes_deployment_image_pull_policy_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"name",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "name"},
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
						"image": "your_image:latest",
						"image_pull_policy": "Always",
						"name": "container name",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 12,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_image_pull_policy_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"name",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "name"},
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
						"image": "your_image:any",
						"image_pull_policy": "",
						"name": "container name",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 11,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 12,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 13,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
