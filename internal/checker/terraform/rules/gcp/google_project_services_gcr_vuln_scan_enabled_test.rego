package lib.terraform.CB_TFGCP_109

test_google_project_services_gcr_vuln_scan_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_services",
			"pass_1",
		],
		"Attributes": {
			"project": "your-project-id",
			"services": [
				"iam.googleapis.com",
				"cloudresourcemanager.googleapis.com",
				"containerscanning.googleapis.com",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_project_services_gcr_vuln_scan_disabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_project_services",
			"pass_1",
		],
		"Attributes": {
			"project": "your-project-id",
			"services": [
				"iam.googleapis.com",
				"cloudresourcemanager.googleapis.com",
			],
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
