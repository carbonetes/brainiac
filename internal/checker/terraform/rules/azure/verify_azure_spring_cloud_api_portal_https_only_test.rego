package lib.terraform.CB_TFAZR_176

test_azure_spring_cloud_api_portal_https_only_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_spring_cloud_api_portal",
            "pass"
        ],
        "Attributes": {
            "https_only_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_spring_cloud_api_portal_https_only_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_spring_cloud_api_portal",
            "pass"
        ],
        "Attributes": {
            "https_only_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}