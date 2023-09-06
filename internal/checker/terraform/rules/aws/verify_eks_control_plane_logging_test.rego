package lib.terraform.CB_TFAWS_034

test_eks_control_plane_logging_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_eks_cluster",
			"example",
		],
		"Attributes": {"enabled_cluster_log_types": [
			"api",
			"audit",
			"authenticators",
			"controllerManager",
			"schedulers",
		]},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_eks_control_plane_logging_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_eks_cluster",
			"example",
		],
		"Attributes": {"enabled_cluster_log_types": [
			"api",
			"audit",
			"authenticators",
			"controllerManager",
		]},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
