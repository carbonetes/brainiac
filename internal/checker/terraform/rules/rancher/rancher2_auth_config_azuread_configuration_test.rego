package lib.terraform.CB_TFRAN_011

test_rancher2_auth_config_azuread_configuration_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_azuread",
            "azuread"
        ],
        "Attributes": {
            "application_id": "<AZUREAD_APP_ID>",
            "application_secret": "<AZUREAD_APP_SECRET>",
            "auth_endpoint": "<AZUREAD_AUTH_ENDPOINT>",
            "graph_endpoint": "<AZUREAD_GRAPH_ENDPOINT>",
            "rancher_url": "<RANCHER_URL>",
            "tenant_id": "<AZUREAD_TENANT_ID>",
            "token_endpoint": "<AZUREAD_TOKEN_ENDPOINT>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}

test_rancher2_auth_config_azuread_configuration_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "rancher2_auth_config_azuread",
            "azuread"
        ],
        "Attributes": {
            "application_id": "<AZUREAD_APP_ID>",
            "application_secret": "<AZUREAD_APP_SECRET>",
            "auth_endpoint": "<AZUREAD_AUTH_ENDPOINT>",
            "graph_endpoint": "<AZUREAD_GRAPH_ENDPOINT>",
            "rancher_url": "<RANCHER_URL>",
            "tenant_id": "<AZUREAD_TENANT_ID>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 2
        }
    }]
    count(result) == 1
}
