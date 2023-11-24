package lib.terraform.CB_TFGCP_102

test_default_service_account_not_used {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_project_default_service_accounts",
				"not_ok",
			],
			"Attributes": {
				"action": "DELETE",
				"id": "1234",
				"project": "my-project-id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_container_node_pool",
				"primary_A_not_ok",
			],
			"Attributes": {
				"name": "node-pool",
				"oauth_scopes": ["https://www.googleapis.com/auth/cloud-platform"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}

test_default_service_account_used {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_project_default_service_accounts",
				"not_ok",
			],
			"Attributes": {
				"action": "DELETE",
				"id": "1234",
				"project": "my-project-id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 5,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_container_node_pool",
				"primary_A_not_ok",
			],
			"Attributes": {
				"name": "node-pool",
				"oauth_scopes": ["https://www.googleapis.com/auth/cloud-platform"],
				"service_account": "google_project_default_service_accounts.not_ok.id",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 14,
				"startLine": 7,
			},
		},
	]
	count(result) == 1
}
