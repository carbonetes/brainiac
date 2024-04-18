package lib.terraform.CB_TFIBM_029

import rego.v1 

test_tfibm_appid_application_is_supported_type_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_application",
            "app"
        ],
        "Attributes": {
            "name": "example application",
            "tenant_id": "var.tenant_id",
            "type": "singlepageapp"
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

test_tfibm_appid_application_is_supported_type_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_application",
            "app"
        ],
        "Attributes": {
            "name": "example application",
            "tenant_id": "var.tenant_id",
            "type": "var.application_type"
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