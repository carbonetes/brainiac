package lib.terraform.CB_TFAZR_102

test_azurerm_data_factory_no_public_network_access_passed {
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
                "azurerm_data_factory",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "public_network_access": false,
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 11,
                "startLine": 6
            }
        }
    ]

    count(result) == 1
}

test_azurerm_data_factory_no_public_network_access_failed {
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
                "azurerm_data_factory",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "public_network_access": true,
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 11,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}
