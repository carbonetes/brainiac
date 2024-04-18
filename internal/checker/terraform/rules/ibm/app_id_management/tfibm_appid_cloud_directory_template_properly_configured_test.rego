package lib.terraform.CB_TFIBM_040

import rego.v1 

test_tfibm_appid_cloud_directory_template_is_properly_configured_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_cloud_directory_template",
            "tpl"
        ],
        "Attributes": {
            "subject": "Please Verify Your Email Address %{user.displayName}",
            "template_name": "USER_VERIFICATION",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_cloud_directory_template_is_not_properly_configured_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_cloud_directory_template",
            "tpl"
        ],
        "Attributes": {
            "subject": "Please Verify Your Email Address %{user.displayName}",
            "template_name": "US_VERIFICATIO",
            "tenant_id": "var.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }
]
	count(result) == 1
}