package lib.terraform.CB_TFAZR_221

test_azurerm_automation_account_not_overly_permissive_network_access_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_automation_account",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-account",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Basic",
                "tags": {
                    "environment": "development"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_automation_account_not_overly_permissive_network_access_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West Europe",
                "name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_automation_account",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-account",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Basic",
                "tags": {
                    "environment": "development"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}