package lib.terraform.CB_TFGCP_034

test_bigquery_datasets_not_publicly_available {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_dataset",
			"pass_special_group",
		],
		"Attributes": {
			"dataset_id": "example_dataset",
			"description": "This is a test description",
			"friendly_name": "test",
			"location": "US",
		},
		"Blocks": [{
			"Type": "access",
			"Labels": [],
			"Attributes": {
				"role": "OWNER",
				"group_by_email": "google_service_account.bqowner.email",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_bigquery_datasets_publicly_available {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_dataset",
			"pass_special_group",
		],
		"Attributes": {
			"dataset_id": "example_dataset",
			"description": "This is a test description",
			"friendly_name": "test",
			"location": "US",
		},
		"Blocks": [{
			"Type": "access",
			"Labels": [],
			"Attributes": {"role": "OWNER"},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 7,
			},
		}],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
