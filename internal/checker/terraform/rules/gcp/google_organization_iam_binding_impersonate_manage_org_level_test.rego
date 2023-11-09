package lib.terraform.CB_TFGCP_014

test_google_organization_iam_binding_impersonate_manage_org_level_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_organization_iam_member",
			"example",
		],
		"Attributes": {
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"org_id": "your-org-id",
			"role": "roles/logging.viewer",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_organization_iam_binding_impersonate_manage_org_level_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_organization_iam_member",
			"example",
		],
		"Attributes": {
			"member": "user:test@example-project.iam.gserviceaccount.com",
			"org_id": "your-org-id",
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
