package lib.terraform.CB_TFK8S_005

test_kubernetes_pod_security_policy_allowprivilegeescalation_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"share_host_pid_psp",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "share-host-pid-psp"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {"allow_privilege_escalation": false},
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

test_kubernetes_pod_security_policy_allowprivilegeescalation_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"kubernetes_pod_security_policy",
			"share_host_pid_psp",
		],
		"Attributes": {},
		"Blocks": [
			{
				"Type": "metadata",
				"Labels": [],
				"Attributes": {"name": "share-host-pid-psp"},
				"Blocks": [],
				"line_range": {
					"endLine": 4,
					"startLine": 2,
				},
			},
			{
				"Type": "spec",
				"Labels": [],
				"Attributes": {"allow_privilege_escalation": true},
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
