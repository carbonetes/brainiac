package lib.terraform.CB_TFGCP_026

test_google_project_iam_binding_service_acc_project_level_emulate_deny_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"example",
		],
		"Attributes": {
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"project": "project/1234567",
			"role": "roles/bigquery.dataViewer",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_project_iam_binding_service_acc_project_level_emulate_deny_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"example",
		],
		"Attributes": {
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"project": "project/1234567",
			"role": "roles/iam.securityAdmin",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
