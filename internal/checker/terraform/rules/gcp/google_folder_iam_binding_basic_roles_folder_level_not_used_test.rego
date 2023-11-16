package lib.terraform.CB_TFGCP_079

test_google_folder_iam_binding_basic_roles_folder_level_not_used_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_binding",
			"example",
		],
		"Attributes": {
			"folder": "<your_folder_id>",
			"members": ["user:valid@example.com"],
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

test_google_folder_iam_binding_basic_roles_folder_level_not_used_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_binding",
			"example",
		],
		"Attributes": {
			"folder": "<your_folder_id>",
			"members": ["user:valid@example.com"],
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
