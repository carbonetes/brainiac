package lib.terraform.CB_TFGCP_105

test_cloud_audit_logging_configured_across_all_svc_and_user_project_passed {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_project",
				"bad_project",
			],
			"Attributes": {
				"name": "bad",
				"project_id": "123456",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_project_iam_audit_config",
				"project_bad_audit",
			],
			"Attributes": {
				"project": "google_project.bad_project.id",
				"service": "allServices",
			},
			"Blocks": [
				{
					"Type": "audit_log_config",
					"Labels": [],
					"Attributes": {"log_type": "ADMIN_READ"},
					"Blocks": [],
					"line_range": {
						"endLine": 25,
						"startLine": 23,
					},
				},
				{
					"Type": "audit_log_config",
					"Labels": [],
					"Attributes": {
						"exempted_members": [],
						"log_type": "DATA_READ",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 31,
						"startLine": 26,
					},
				},
			],
			"line_range": {
				"endLine": 32,
				"startLine": 20,
			},
		},
	]
	count(result) == 1
}

test_cloud_audit_logging_configured_across_all_svc_and_user_project_failed {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"google_project",
				"bad_project",
			],
			"Attributes": {
				"name": "bad",
				"project_id": "123456",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"google_project_iam_audit_config",
				"project_bad_audit",
			],
			"Attributes": {
				"project": "google_project.bad_project.id",
				"service": "allServices",
			},
			"Blocks": [
				{
					"Type": "audit_log_config",
					"Labels": [],
					"Attributes": {"log_type": "ADMIN_READ"},
					"Blocks": [],
					"line_range": {
						"endLine": 25,
						"startLine": 23,
					},
				},
				{
					"Type": "audit_log_config",
					"Labels": [],
					"Attributes": {
						"exempted_members": ["user:jayson@carbo.com"],
						"log_type": "DATA_READ",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 31,
						"startLine": 26,
					},
				},
			],
			"line_range": {
				"endLine": 32,
				"startLine": 20,
			},
		},
	]
	count(result) == 1
}
