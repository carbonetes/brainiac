package lib.terraform.CB_TFIBM_098

import rego.v1 

test_tfibm_appid_idp_cloud_directory_identity_confirm_method_allowed_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_application_cloud_directory",
            "cd"
        ],
        "Attributes": {
            "identity_confirm_methods": [
                "email"
            ],
            "identity_field": "email",
            "is_active": true,
            "reset_password_enabled": false,
            "reset_password_notification_enabled": false,
            "self_service_enabled": false,
            "signup_enabled": false,
            "tenant_id": "var.tenant_id",
            "welcome_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_tfibm_appid_idp_cloud_directory_identity_confirm_method_allowed_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_appid_application_cloud_directory",
            "cd"
        ],
        "Attributes": {
            "identity_confirm_methods": [
                "email1"
            ],
            "identity_field": "email",
            "is_active": true,
            "reset_password_enabled": false,
            "reset_password_notification_enabled": false,
            "self_service_enabled": false,
            "signup_enabled": false,
            "tenant_id": "var.tenant_id",
            "welcome_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }
]
	count(result) == 1
}