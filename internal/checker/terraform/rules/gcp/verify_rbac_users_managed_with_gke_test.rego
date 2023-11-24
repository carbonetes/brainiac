package lib.terraform.CB_TFGCP_051

test_rbac_users_managed_with_gke {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "authenticator_groups_config",
			"Labels": [],
			"Attributes": {"security_group": "gke-security-groups@yourdomain.com"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_rbac_users_not_managed_with_gke {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_container_cluster",
			"example",
		],
		"Attributes": {"name": "test"},
		"Blocks": [{
			"Type": "authenticator_groups_config",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
