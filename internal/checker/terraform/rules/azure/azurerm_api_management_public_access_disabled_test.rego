package lib.terraform.CB_TFAZR_144

test_azurerm_api_management_public_access_disabled_passed {
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
                "azurerm_api_management",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-apim",
                "public_network_access_enabled": false,
                "publisher_email": "company@terraform.io",
                "publisher_name": "My Company",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Developer_1"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_api_management_public_access_disabled_failed {
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
                "azurerm_api_management",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-apim",
                "public_network_access_enabled": true,
                "publisher_email": "company@terraform.io",
                "publisher_name": "My Company",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Developer_1"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}