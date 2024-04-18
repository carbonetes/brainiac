package lib.terraform.CB_TFIBM_60

import rego.v1 

test_tfibm_appid_action_url_is_https_protocol_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_action_url",
            "url"
        ],
        "Attributes": {
            "action": "on_user_verified",
            "tenant_id": "var.tenant_id",
            "url": "https://exammple.com"
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

test_tfibm_appid_action_url_is_not_https_protocol_failed  if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_action_url",
            "url"
        ],
        "Attributes": {
            "action": "on_user_verified",
            "tenant_id": "var.tenant_id",
            "url": "http://exammple.com"
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