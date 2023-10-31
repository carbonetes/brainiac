package lib.terraform.CB_TFAZR_207

test_azurerm_search_service_allowed_ips_not_global_passed {
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
                "allowed_ips": [
                    "192.168.1.1",
                    "10.0.0.1",
                    "172.16.0.1"
                ],
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard3"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}

test_azurerm_search_service_allowed_ips_not_global_failed {
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
                "allowed_ips": [
                    "192.168.1.1",
                    "10.0.0.1",
                    "0.0.0.0/0",
                    "172.16.0.1"
                ],
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard3"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}
