package lib.terraform.CB_TFAZR_048

test_azure_app_service_ftps_state_passed {
	result := passed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "ftps_state": "Disabled"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_app_service_ftps_state_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "azurerm"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "features",
                "Labels": [],
                "Attributes": {},
                "Blocks": [],
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_app_service",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "ftps_state": "Enabled"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 13,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 14,
            "startLine": 10
        }
    }]
	count(result) == 1
}
