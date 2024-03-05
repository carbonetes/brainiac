package lib.terraform.CB_TFRAN_024

test_rancher2_auth_config_okta_configuration_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_okta",
            "okta"
        ],
        "Attributes": {
            "display_name_field": "<DISPLAY_NAME_FIELD>",
            "groups_field": "<GROUPS_FIELD>",
            "idp_metadata_content": "<IDP_METADATA_CONTENT>",
            "rancher_api_host": "https://<RANCHER_API_HOST>",
            "sp_cert": "<SP_CERT>",
            "sp_key": "<SP_KEY>",
            "uid_field": "<UID_FIELD>",
            "user_name_field": "<USER_NAME_FIELD>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
count(result) == 1
}

test_rancher2_auth_config_okta_configuration_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_okta",
            "okta"
        ],
        "Attributes": {
            "display_name_field": "<DISPLAY_NAME_FIELD>",
            "groups_field": "<GROUPS_FIELD>",
            "idp_metadata_content": "<IDP_METADATA_CONTENT>",
            "rancher_api_host": "https://<RANCHER_API_HOST>",
            "sp_cert": "<SP_CERT>",
            "sp_key": "<SP_KEY>",
            "uid_field": "<UID_FIELD>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
count(result) == 1
}