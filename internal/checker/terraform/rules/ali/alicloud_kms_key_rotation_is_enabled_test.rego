package lib.terraform.CB_TFALI_017

test_alicloud_kms_key_rotation_is_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_kms_key",
            "key"
        ],
        "Attributes": {
            "automatic_rotation": "Enabled",
            "description": "Hello KMS",
            "pending_window_in_days": "7",
            "status": "Enabled"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_alicloud_kms_key_rotation_is_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "alicloud_kms_key",
            "key"
        ],
        "Attributes": {
            "automatic_rotation": "Disabled",
            "description": "Hello KMS",
            "pending_window_in_days": "7",
            "status": "Enabled"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    }]
	count(result) == 1
}
