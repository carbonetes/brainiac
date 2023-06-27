package lib.terraform.CB_TFOCI_012

test_oci_iam_password_policy_has_lowercase {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_identity_authentication_policy",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "password_policy",
			"Labels": [],
			"Attributes": {"is_lowercase_characters_required": true},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_iam_password_policy_no_lowercase {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_identity_authentication_policy",
			"pass",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "password_policy",
			"Labels": [],
			"Attributes": {"is_lowercase_characters_required": false},
			"Blocks": [],
			"line_range": {
				"endLine": 6,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 7,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
