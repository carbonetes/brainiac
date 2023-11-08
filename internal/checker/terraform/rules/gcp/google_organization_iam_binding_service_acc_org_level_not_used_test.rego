package lib.terraform.CB_TFGCP_018

test_google_organization_iam_binding_service_acc_org_level_not_used_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_organization_iam_member",
			"organization",
		],
		"Attributes": {
			"org_id": "your-org-id",
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

test_google_organization_iam_binding_service_acc_org_level_not_used_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_organization_iam_member",
			"organization",
		],
		"Attributes": {
			"member": "project-number-compute@developer.gserviceaccount.com",
			"org_id": "your-org-id",
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
