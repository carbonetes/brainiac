package lib.terraform.CB_TFGCP_006

test_google_folder_iam_binding_manage_service_acc_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_member",
			"example",
		],
		"Attributes": {
			"folder": "folders/1234567",
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"role": "roles/compute.instanceAdmin"
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_folder_iam_binding_manage_service_acc_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_folder_iam_member",
			"example",
		],
		"Attributes": {
			"folder": "folders/1234567",
			"member": "user:test@example-project.iam.gserviceaccount.com",
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
