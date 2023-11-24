package lib.terraform.CB_TFGCP_022

test_google_folder_iam_binding_service_acc_folder_level_not_used_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_member",
			"folder",
		],
		"Attributes": {
			"folder": "folders/1234567",
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

test_google_folder_iam_binding_service_acc_folder_level_not_used_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_member",
			"folder",
		],
		"Attributes": {
			"folder": "folders/1234567",
			"member": "project-number-compute@developer.gserviceaccount.com",
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
