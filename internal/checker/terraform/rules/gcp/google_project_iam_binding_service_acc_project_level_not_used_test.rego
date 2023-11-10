package lib.terraform.CB_TFGCP_016

test_google_project_iam_binding_service_acc_project_level_not_used_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"project",
		],
		"Attributes": {
			"project": "project/1234567",
			"role": "roles/owner",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_project_iam_binding_service_acc_project_level_not_used_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"project",
		],
		"Attributes": {
			"member": "project-id@appspot.gserviceaccount.com",
			"project": "project/1234567",
			"role": "roles/owner",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
