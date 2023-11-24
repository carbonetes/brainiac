package lib.terraform.CB_TFGCP_081

test_big_query_table_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_table",
			"pass",
		],
		"Attributes": {
			"dataset_id": "google_bigquery_dataset.default.dataset_id",
			"table_id": "sheet",
		},
		"Blocks": [{
			"Type": "encryption_configuration",
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

test_big_query_table_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigquery_table",
			"pass",
		],
		"Attributes": {
			"dataset_id": "google_bigquery_dataset.default.dataset_id",
			"table_id": "sheet",
		},
		"Blocks": [{
			"Type": "encryption_configuration",
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
