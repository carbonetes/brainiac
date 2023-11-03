package lib.terraform.CB_TFAZR_094

test_azure_app_service_used_azure_files_passed {
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
                "Type": "storage_account",
                "Labels": [],
                "Attributes": {
                    "name": "test_name",
                    "type": "AzureFiles"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_app_service_used_azure_files_failed {
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
                "Type": "storage_account",
                "Labels": [],
                "Attributes": {
                    "name": "test_name",
                    "type": "notAzureFiles"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 9,
                    "startLine": 6
                }
            }
        ],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}