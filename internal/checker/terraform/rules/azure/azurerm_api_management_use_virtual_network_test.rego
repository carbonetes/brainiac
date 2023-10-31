package lib.terraform.CB_TFAZR_105

test_azurerm_api_management_use_virtual_network_passed {
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
                "publisher_email": "company@terraform.io",
                "publisher_name": "My Company",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Developer_1"
            },
            "Blocks": [
                {
                    "Type": "virtual_network_configuration",
                    "Labels": [],
                    "Attributes": {
                        "subnet_id": "sample_subnet_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 17,
                        "startLine": 15
                    }
                }
            ],
            "line_range": {
                "endLine": 18,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}

test_azurerm_api_management_use_virtual_network_failed {
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
                "publisher_email": "company@terraform.io",
                "publisher_name": "My Company",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "Developer_1"
            },
            "line_range": {
                "endLine": 18,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}