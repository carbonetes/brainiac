package lib.terraform.CB_TFIBM_080

import rego.v1 

test_tfibm_appid_application_is_supported_type_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_mfa_channel",
            "mf"
        ],
        "Attributes": {
            "active": "sms",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "sms_config",
                "Labels": [],
                "Attributes": {
                    "from": "+11112223333",
                    "key": "<nexmo key>",
                    "secret": "<nexmo secret>"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_application_is_supported_type_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_mfa_channel",
            "mf"
        ],
        "Attributes": {
            "active": "sms",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [
            {
                "Type": "sms_config",
                "Labels": [],
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 5
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }
]
	count(result) == 1
}