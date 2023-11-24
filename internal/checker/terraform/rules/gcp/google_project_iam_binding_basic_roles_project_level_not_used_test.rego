package lib.terraform.CB_TFGCP_083

test_google_project_iam_binding_basic_roles_project_level_not_used_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_binding",
			"example",
		],
		"Attributes": {
			"members": ["user:example@example.com"],
			"project": "<your_project_id>",
			"role": "roles/browser",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_project_iam_binding_basic_roles_project_level_not_used_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_iam_binding",
			"example",
		],
		"Attributes": {
			"members": ["user:example@example.com"],
			"project": "<your_project_id>",
			"role": "roles/editor",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
