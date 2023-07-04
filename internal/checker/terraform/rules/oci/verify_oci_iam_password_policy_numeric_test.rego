package lib.terraform.CB_TFOCI_013

test_oci_iam_password_policy_has_numeric {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_identity_authentication_policy",
			"password_policy",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "password_policy",
			"Labels": [],
			"Attributes": {"is_numeric_characters_required": true},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_oci_iam_password_policy_no_numeric {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"oci_identity_authentication_policy",
			"password_policy",
		],
		"Attributes": {},
		"Blocks": [{
			"Type": "password_policy",
			"Labels": [],
			"Attributes": {"is_numeric_characters_required": false},
			"Blocks": [],
			"line_range": {
				"endLine": 4,
				"startLine": 2,
			},
		}],
		"line_range": {
			"endLine": 5,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
