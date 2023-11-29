package lib.terraform.CB_TFALI_008

test_alicloud_ram_account_password_policy_max_login_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_ram_account_password_policy",
            "corporate"
        ],
        "Attributes": {
            "hard_expiry": true,
            "max_login_attempts": "5",
            "max_password_age": "12",
            "minimum_password_length": "9",
            "password_reuse_prevention": "5",
            "require_lowercase_characters": false,
            "require_numbers": false,
            "require_symbols": false,
            "require_uppercase_characters": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_alicloud_ram_account_password_policy_max_login_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_ram_account_password_policy",
            "corporate"
        ],
        "Attributes": {
            "hard_expiry": true,
            "max_login_attempts": "9",
            "max_password_age": "12",
            "minimum_password_length": "9",
            "password_reuse_prevention": "5",
            "require_lowercase_characters": false,
            "require_numbers": false,
            "require_symbols": false,
            "require_uppercase_characters": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 1
        }
    }]
	count(result) == 1
}
