package lib.terraform.CB_TFK8S_026

test_kubernetes_deployment_default_namespace_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"example_pod",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "metadata",
			"Labels": [],
			"Attributes": {
				"name": "example-pod",
				"namespace": "your_namespace",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_default_namespace_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod",
			"example_pod",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "metadata",
			"Labels": [],
			"Attributes": {
				"name": "example-pod",
				"namespace": "default",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
