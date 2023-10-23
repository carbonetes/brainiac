package lib.terraform.CB_TFAZR_204

test_azurerm_search_service_managed_identity_passed {
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
                "azurerm_search_service",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard"
            },
            "Blocks": [
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 12
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}

test_azurerm_search_service_managed_identity_failed {
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
                "azurerm_search_service",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard"
            },
            "Blocks": [
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "UserAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 12
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}
