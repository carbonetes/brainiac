package lib.terraform.CB_TFRAN_018

test_rancher2_auth_config_github_configuration_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_github",
            "github"
        ],
        "Attributes": {
            "enabled": false,
            "client_id": "",
            "client_secret": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_auth_config_github_configuration_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_github",
            "github"
        ],
        "Attributes": {
            "enabled": false,
            "client_id": "<GITHUB_CLIENT_ID>",
            "client_secret": "<GITHUB_CLIENT_SECRET>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 2
        }
    }]
    count(result) == 1
}
