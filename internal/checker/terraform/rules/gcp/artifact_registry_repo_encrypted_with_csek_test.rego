package lib.terraform.CB_TFGCP_086

test_artifact_registry_repo_encrypted_with_csek {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_artifact_registry_repository",
			"pass",
		],
		"Attributes": {
			"kms_key_name": "google_kms_key",
			"name": "example",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_artifact_registry_repo_not_encrypted_with_csek {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_artifact_registry_repository",
			"pass",
		],
		"Attributes": {"name": "example"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
