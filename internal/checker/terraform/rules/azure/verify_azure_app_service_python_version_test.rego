package lib.terraform.CB_TFAZR_069

test_azure_app_service_python_version_passed {
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
                    "python_version": "3.4"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_app_service_python_version_failed {
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
                    "python_version": "2.6"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 8,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 9,
            "startLine": 5
        }
    }]
	count(result) == 1
}