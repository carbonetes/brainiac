package lib.terraform.CB_TFGCP_094

test_data_flow_jobs_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dataflow_job",
			"pass",
		],
		"Attributes": {
			"kms_key_name": "secret-carbo",
			"name": "dataflow-job",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_data_flow_jobs_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_dataflow_job",
			"pass",
		],
		"Attributes": {"name": "dataflow-job"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
