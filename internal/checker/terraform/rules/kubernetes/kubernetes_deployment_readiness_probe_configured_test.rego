package lib.terraform.CB_TFK8S_011

test_kubernetes_deployment_readiness_probe_configured_passed {
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
				"Attributes": {},
				"Blocks": [{
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "nginx",
						"name": "example-container",
					},
					"Blocks": [{
						"Type": "readiness_probe",
						"Labels": [],
						"Attributes": {
							"initial_delay_seconds": "3",
							"period_seconds": "10",
						},
						"Blocks": [{
							"Type": "http_get",
							"Labels": [],
							"Attributes": {
								"path": "/",
								"port": "80",
								"scheme": "HTTP",
							},
							"Blocks": [],
							"line_range": {
								"endLine": 16,
								"startLine": 12,
							},
						}],
						"line_range": {
							"endLine": 20,
							"startLine": 11,
						},
					}],
					"line_range": {
						"endLine": 21,
						"startLine": 7,
					},
				}],
				"line_range": {
					"endLine": 22,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 23,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_deployment_readiness_probe_configured_failed {
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
				"Attributes": {},
				"Blocks": [{
					"Type": "container",
					"Labels": [],
					"Attributes": {
						"image": "nginx",
						"name": "example-container",
					},
					"Blocks": [],
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
