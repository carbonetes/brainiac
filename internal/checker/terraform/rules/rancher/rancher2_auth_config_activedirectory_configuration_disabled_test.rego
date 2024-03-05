package lib.terraform.CB_TFRAN_021

test_rancher2_auth_config_activedirectory_configuration_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "enabled": false,
            "servers": [],
            "service_account_password": "",
            "service_account_username": "",
            "test_username": "",
            "test_password": "",
            "user_search_base": "",
            "group_search_base": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_auth_config_activedirectory_configuration_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "enabled": false,
            "servers": ["<ACTIVEDIRECTORY_SERVER>"],
            "service_account_password": "<SERVICE_PASSWORD>",
            "service_account_username": "<SERVICE_DN>",
            "test_password": "<USER_PASSWORD>",
            "test_username": "<USER_NAME>",
            "user_search_base": "<SEARCH_BASE>",
            "group_search_base": "<GROUP_BASE>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}
