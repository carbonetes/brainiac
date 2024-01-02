package lib.terraform.CB_TFK8S_022

test_kubernetes_deployment_fixed_image_tag_passed {
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
				"Attributes": {"name": "example-pod"},
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
						"image": "example-image:1.2.3",
						"name": "example-container",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 11,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_fixed_image_tag_failed {
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
				"Attributes": {"name": "example-pod"},
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
						"image": "example-image:latest",
						"name": "example-container",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 10,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 11,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 12,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
