package lib.terraform.CB_TFOCI_014

test_oci_iam_password_policy_has_special_characters {
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
			"Attributes": {"is_special_characters_required": true},
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

test_oci_iam_password_policy_no_special_characters {
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
			"Attributes": {"is_special_characters_required": false},
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
