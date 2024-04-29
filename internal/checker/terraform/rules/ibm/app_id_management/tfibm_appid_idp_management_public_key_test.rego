package lib.terraform.CB_TFIBM_076

import rego.v1 

test_tfibm_appid_idp_management_public_key_exist_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_idp_custom",
            "idp"
        ],
        "Attributes": {
            "is_active": true,
            "tenant_id": "var.tenant_id",
            "public_key": "/path/to/public/key"
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

test_tfibm_appid_idp_management_public_key_not_exist_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_idp_custom",
            "idp"
        ],
        "Attributes": {
            "is_active": true,
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