package lib.terraform.CB_TFRAN_008

test_rancher2_auth_config_activedirectory_server_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "servers": [
                "ad-server-01.company.local",
                "ad-server-02.company.local",
                "ad-server-03.company.local",
                "ad-server-04.company.local",
                "ad-server-05.company.local"
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

test_rancher2_auth_config_activedirectory_server_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_activedirectory",
            "activedirectory"
        ],
        "Attributes": {
            "servers": [
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
