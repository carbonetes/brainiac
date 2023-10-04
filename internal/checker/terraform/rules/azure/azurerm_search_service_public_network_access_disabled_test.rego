package lib.terraform.CB_TFAZR_127


test_azurerm_search_service_public_network_access_disabled_passed {
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
                "authentication_failure_mode": "http403",
                "local_authentication_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard"
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

test_azurerm_search_service_public_network_access_disabled_failed {
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
                "authentication_failure_mode": "http403",
                "local_authentication_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard"
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