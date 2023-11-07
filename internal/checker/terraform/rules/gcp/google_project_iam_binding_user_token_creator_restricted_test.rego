package lib.terraform.CB_TFGCP_003

test_google_project_iam_binding_user_token_creator_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_binding",
			"project",
		],
		"Attributes": {
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

test_google_project_iam_binding_user_token_creator_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_binding",
			"project",
		],
		"Attributes": {
			"project": "your-project-id",
			"role": "roles/iam.serviceAccountTokenCreator",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
