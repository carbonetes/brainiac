package lib.terraform.CB_TFAZR_008

test_azure_storage_account_name_passed {
	result := passed with input as [{
        "Attributes": {},
        "Blocks": [
            {
                "Attributes": {},
                "Blocks": [],
                "Labels": [],
                "Type": "features",
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "Labels": [
            "azurerm"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "location": "East US",
            "name": "example-resources"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "enable_https_traffic_only": true,
            "location": "azurerm_resource_group.example.location",
            "name": "correctname",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_storage_account",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 17,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_storage_account_name_failed {
	result := failed with input as [{
        "Attributes": {},
        "Blocks": [
            {
                "Attributes": {},
                "Blocks": [],
                "Labels": [],
                "Type": "features",
                "line_range": {
                    "endLine": 2,
                    "startLine": 2
                }
            }
        ],
        "Labels": [
            "azurerm"
        ],
        "Type": "provider",
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "location": "East US",
            "name": "example-resources"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 8,
            "startLine": 5
        }
    },
    {
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "enable_https_traffic_only": true,
            "location": "azurerm_resource_group.example.location",
            "name": "Incorrect_name",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_storage_account",
            "example"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 17,
            "startLine": 10
        }
    }]
	count(result) == 1
}
