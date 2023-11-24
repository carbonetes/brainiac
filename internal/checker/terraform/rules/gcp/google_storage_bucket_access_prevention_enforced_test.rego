package lib.terraform.CB_TFGCP_089

test_google_storage_bucket_access_prevention_enforced_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"example",
		],
		"Attributes": {
			"force_destroy": true,
			"location": "us-central1",
			"name": "your-bucket-name",
			"public_access_prevention": "enforced",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_storage_bucket_access_prevention_enforced_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_storage_bucket",
			"example",
		],
		"Attributes": {
			"force_destroy": true,
			"location": "us-central1",
			"name": "your-bucket-name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
