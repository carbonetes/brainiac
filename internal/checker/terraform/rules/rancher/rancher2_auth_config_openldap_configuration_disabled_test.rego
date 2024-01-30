package lib.terraform.CB_TFRAN_029

test_rancher2_auth_config_openldap_configuration_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_openldap",
            "openldap"
        ],
        "Attributes": {
            "enabled": false,
            "servers": [
            ],
            "service_account_distinguished_name": "",
            "service_account_password": "",
            "test_password": "",
            "test_username": "",
            "user_search_base": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_auth_config_openldap_configuration_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_openldap",
            "openldap"
        ],
        "Attributes": {
            "enabled": false,
            "servers": [
                "<OPENLDAP_SERVER>"
            ],
            "service_account_distinguished_name": "<SERVICE_DN>",
            "service_account_password": "<SERVICE_PASSWORD>",
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
