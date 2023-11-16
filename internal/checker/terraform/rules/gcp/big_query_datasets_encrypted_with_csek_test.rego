package lib.terraform.CB_TFGCP_082

test_big_query_datasets_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_dataset",
			"pass",
		],
		"Attributes": {
			"dataset_id": "google_bigquery_dataset.default.dataset_id",
			"table_id": "sheet",
		},
		"Blocks": [{
			"Type": "default_encryption_configuration",
			"Labels": [],
			"Attributes": {"kms_key_name": "var.kms_key_name"},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_big_query_datasets_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_dataset",
			"pass",
		],
		"Attributes": {
			"dataset_id": "google_bigquery_dataset.default.dataset_id",
			"table_id": "sheet",
		},
		"Blocks": [{
			"Type": "default_encryption_configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 7,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 8,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
