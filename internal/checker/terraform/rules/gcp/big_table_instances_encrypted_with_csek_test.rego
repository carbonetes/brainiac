package lib.terraform.CB_TFGCP_087

test_big_table_instances_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigtable_instance",
			"pass",
		],
		"Attributes": {"name": "tf-example"},
		"Blocks": [{
			"Type": "cluster",
			"Labels": [],
			"Attributes": {"kms_key_name": "google_kms_crypto_key.example.name"},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_big_table_instances_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_bigtable_instance",
			"pass",
		],
		"Attributes": {"name": "tf-example"},
		"Blocks": [{
			"Type": "cluster",
			"Labels": [],
			"Attributes": {},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 4,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
