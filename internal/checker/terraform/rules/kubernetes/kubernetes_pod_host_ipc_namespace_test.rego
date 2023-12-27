package lib.terraform.CB_TFK8S_037

test_kubernetes_pod_host_ipc_namespace_passed {
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
				"Attributes": {"host_ipc": false},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_pod_host_ipc_namespace_failed {
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
				"Attributes": {"host_ipc": true},
				"Blocks": [],
				"line_range": {
					"endLine": 9,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
