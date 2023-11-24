package lib.terraform.CB_TFGCP_005

test_google_project_iam_member_admin_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"project",
		],
		"Attributes": {"project": "your-project-id"},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_project_iam_member_admin_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_member",
			"project",
		],
		"Attributes": {
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"project": "your-project-id",
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
