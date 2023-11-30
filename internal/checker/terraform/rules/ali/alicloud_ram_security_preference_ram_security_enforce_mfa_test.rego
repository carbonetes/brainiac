package lib.terraform.CB_TFALI_009

test_alicloud_ram_security_preference_ram_security_enforce_mfa_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_ram_security_preference",
            "example"
        ],
        "Attributes": {
            "allow_user_to_change_password": true,
            "enable_save_mfa_ticket": false,
            "enforce_mfa_for_login": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_alicloud_ram_security_preference_ram_security_enforce_mfa_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_ram_security_preference",
            "example"
        ],
        "Attributes": {
            "allow_user_to_change_password": true,
            "enable_save_mfa_ticket": false,
            "enforce_mfa_for_login": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}
