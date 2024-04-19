package lib.terraform.CB_TFIBM_068

import rego.v1 

test_tfibm_appid_application_is_supported_type_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_redirect_urls",
            "urls"
        ],
        "Attributes": {
            "tenant_id": "var.tenant_id",
            "urls": [
                "https://test-application-1.com/login",
                "https://test-application-2.com/login",
                "https://test-application-3.com/login"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
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
            "ibm_appid_redirect_urls",
            "urls"
        ],
        "Attributes": {
            "tenant_id": "var.tenant_id",
            "urls": [
                "http://test-application-1.com/login",
                "http://test-application-2.com/login",
                "http://test-application-3.com/login"
            ]
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }
]
	count(result) == 1
}