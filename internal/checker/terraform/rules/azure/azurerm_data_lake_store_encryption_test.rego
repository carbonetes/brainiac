package lib.terraform.CB_TFAZR_103

test_azurerm_data_lake_store_encryption_passed {
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
                "azurerm_data_lake_store",
                "example"
            ],
            "Attributes": {
                "encryption_state": "Enabled",
                "encryption_type": "ServiceManaged",
                "location": "azurerm_resource_group.example.location",
                "name": "consumptiondatalake",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_data_lake_store_encryption_failed {
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
                "azurerm_data_lake_store",
                "example"
            ],
            "Attributes": {
                "encryption_state": "Disabled",
                "encryption_type": "ServiceManaged",
                "location": "azurerm_resource_group.example.location",
                "name": "consumptiondatalake",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}
