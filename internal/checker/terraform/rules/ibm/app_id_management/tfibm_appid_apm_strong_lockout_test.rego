package lib.terraform.CB_TFIBM_050

import rego.v1 

test_tfibm_appid_apm_strong_lockout_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_apm",
            "apm"
        ],
        "Attributes": {
            "enabled": true,
            "prevent_password_with_username": true,
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "password_reuse",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "max_password_reuse": "4"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            },
            {
                "Type": "password_expiration",
                "Labels": [],
                "Attributes": {
                    "days_to_expire": "25",
                    "enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            },
            {
                "Type": "lockout_policy",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "lockout_time_sec": "1800",
                    "num_of_attempts": "3"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 16
                }
            },
            {
                "Type": "min_password_change_interval",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "min_hours_to_change_password": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_apm_not_strong_lockoutfailed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_apm",
            "apm"
        ],
        "Attributes": {
            "enabled": true,
            "prevent_password_with_username": true,
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "password_reuse",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "max_password_reuse": "4"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            },
            {
                "Type": "password_expiration",
                "Labels": [],
                "Attributes": {
                    "days_to_expire": "25",
                    "enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            },
            {
                "Type": "lockout_policy",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "lockout_time_sec": "1600",
                    "num_of_attempts": "3"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 20,
                    "startLine": 16
                }
            },
            {
                "Type": "min_password_change_interval",
                "Labels": [],
                "Attributes": {
                    "enabled": true,
                    "min_hours_to_change_password": "1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 25,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 26,
            "startLine": 1
        }
    }
]
	count(result) == 1
}