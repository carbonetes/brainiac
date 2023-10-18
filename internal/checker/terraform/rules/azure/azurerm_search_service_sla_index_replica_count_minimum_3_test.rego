package lib.terraform.CB_TFAZR_205

test_azurerm_search_service_sla_index_replica_count_minimum_3_passed {
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
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "replica_count": "3",
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

test_azurerm_search_service_sla_index_replica_count_minimum_3_failed {
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
                "local_authentication_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "example-resource",
                "replica_count": "free",
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
