package lib.terraform.CB_TFALI_027

test_alicloud_ram_account_password_policy_reuse_passed {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_ram_account_password_policy",
			"pass",
		],
		"Attributes": {
			"hard_expiry": true,
			"max_login_attempts": "3",
			"max_password_age": "14",
			"minimum_password_length": "14",
			"password_reuse_prevention": "24",
			"require_lowercase_characters": false,
			"require_numbers": false,
			"require_symbols": true,
			"require_uppercase_characters": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_alicloud_ram_account_password_policy_reuse_failed {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"alicloud_ram_account_password_policy",
			"pass",
		],
		"Attributes": {
			"hard_expiry": true,
			"max_login_attempts": "3",
			"max_password_age": "14",
			"minimum_password_length": "14",
			"password_reuse_prevention": "23",
			"require_lowercase_characters": false,
			"require_numbers": false,
			"require_symbols": true,
			"require_uppercase_characters": false,
		},
		"Blocks": [],
		"line_range": {
			"endLine": 11,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
