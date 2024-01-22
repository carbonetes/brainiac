package lib.terraform.CB_TFRAN_007

test_rancher2_auth_config_activedirectory_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "servers": [
                "<ACTIVEDIRECTORY_SERVER>"
            ],
            "service_account_password": "<SERVICE_PASSWORD>",
            "service_account_username": "<SERVICE_DN>",
            "test_password": "<USER_PASSWORD>",
            "test_username": "<USER_NAME>",
            "user_search_base": "<SEARCH_BASE>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_auth_config_activedirectory_enabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "enabled": false,
            "servers": [
                "<ACTIVEDIRECTORY_SERVER>"
            ],
            "service_account_password": "<SERVICE_PASSWORD>",
            "service_account_username": "<SERVICE_DN>",
            "test_password": "<USER_PASSWORD>",
            "test_username": "<USER_NAME>",
            "user_search_base": "<SEARCH_BASE>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 2
        }
    }]
    count(result) == 1
}
