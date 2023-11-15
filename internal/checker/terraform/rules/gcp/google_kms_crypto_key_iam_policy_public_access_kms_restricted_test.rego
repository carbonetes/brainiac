package lib.terraform.CB_TFGCP_066

test_google_kms_crypto_key_iam_policy_public_access_kms_restricted_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key_iam_policy",
			"example",
		],
		"Attributes": {
			"crypto_key_id": "google_kms_crypto_key.example.id",
			"members": ["passuser"],
			"role": "roles/editor",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_google_kms_crypto_key_iam_policy_public_access_kms_restricted_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"google_kms_crypto_key_iam_policy",
			"example",
		],
		"Attributes": {
			"crypto_key_id": "google_kms_crypto_key.example.id",
			"members": [
				"allUsers",
				"allAuthenticatedUsers",
			],
			"role": "roles/editor",
		},
		"Blocks": [],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
