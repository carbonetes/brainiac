package lib.terraform.CB_TFGCP_115

test_gcp_cloud_function_http_triggered_secured {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_cloudfunctions_function",
			"pass",
		],
		"Attributes": {
			"https_trigger_security_level": "SECURE_ALWAYS",
			"name": "function-test",
			"runtime": "nodejs16",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_gcp_cloud_function_http_triggered_not_secured {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_cloudfunctions_function",
			"pass",
		],
		"Attributes": {
			"https_trigger_security_level": "SECURE_OPTIONAL",
			"name": "function-test",
			"runtime": "nodejs16",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 6,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
