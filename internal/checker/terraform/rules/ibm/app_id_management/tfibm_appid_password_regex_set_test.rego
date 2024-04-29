package lib.terraform.CB_TFIBM_081

import rego.v1 

test_tfibm_appid_password_regex_is_set_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_password_regex",
            "rgx"
        ],
        "Attributes": {
            "error_message": "test error",
            "regex": "^(?:(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).*)$",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_password_regex_is_not_set_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_password_regex",
            "rgx"
        ],
        "Attributes": {
            "error_message": "test error",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }
]
	count(result) == 1
}