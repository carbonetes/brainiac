package lib.terraform.CB_TFGCP_103

test_gcp_manange_service_account_for_each_service_account {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_service_account_key",
			"ok_key",
		],
		"Attributes": {"service_account_id": "google_service_account.account_ok.name"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gcp_manange_service_account_for_each_service_account_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_service_account_key",
			"ok_key",
		],
		"Attributes": {
			"public_key_data": "test",
			"service_account_id": "google_service_account.account_ok.name",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
