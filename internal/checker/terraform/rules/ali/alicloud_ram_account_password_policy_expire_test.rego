package lib.terraform.CB_TFALI_025

test_alicloud_ram_account_password_policy_expire_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_ram_account_password_policy",
			"pass",
		],
		"Attributes": {
			"hard_expiry": true,
			"max_login_attempts": "3",
			"max_password_age": "90",
			"minimum_password_length": "14",
			"password_reuse_prevention": "5",
			"require_lowercase_characters": false,
			"require_numbers": false,
			"require_symbols": true,
			"require_uppercase_characters": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_ram_account_password_policy_expire_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_ram_account_password_policy",
			"pass",
		],
		"Attributes": {
			"hard_expiry": true,
			"max_login_attempts": "3",
			"max_password_age": "91",
			"minimum_password_length": "13",
			"password_reuse_prevention": "5",
			"require_lowercase_characters": false,
			"require_numbers": false,
			"require_symbols": true,
			"require_uppercase_characters": true,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
