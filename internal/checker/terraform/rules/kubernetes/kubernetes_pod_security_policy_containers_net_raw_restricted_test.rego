package lib.terraform.CB_TFK8S_010

test_kubernetes_pod_security_policy_containers_net_raw_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "<policy name>"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {"required_drop_capabilities": [
					"NET_RAW",
					"ALL",
				]},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_kubernetes_pod_security_policy_containers_net_raw_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"example",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "<policy name>"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {"required_drop_capabilities": [""]},
				"Blocks": [],
				"line_range": {
					"endLine": 8,
					"startLine": 6,
				},
			},
		],
		"line_range": {
			"endLine": 9,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
