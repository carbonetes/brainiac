package lib.terraform.CB_TFAZR_178

test_azure_spring_cloud_api_portal_public_access_is_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_spring_cloud_api_portal",
            "pass"
        ],
        "Attributes": {
            "public_network_access_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_spring_cloud_api_portal_public_access_is_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_spring_cloud_api_portal",
            "pass"
        ],
        "Attributes": {
            "public_network_access_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}