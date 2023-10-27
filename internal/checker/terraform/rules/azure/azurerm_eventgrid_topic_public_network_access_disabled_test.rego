package lib.terraform.CB_TFAZR_189

test_azurerm_eventgrid_topic_public_network_access_disabled_passed {
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
                "azurerm_eventgrid_topic",
                "example"
            ],
            "Attributes": {
                "identity": {
                    "type": "SystemAssigned"
                },
                "local_auth_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "my-eventgrid-topic",
                "public_network_access_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 20,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_eventgrid_topic_public_network_access_disabled_failed {
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
                "azurerm_eventgrid_topic",
                "example"
            ],
            "Attributes": {
                "identity": {
                    "type": "SystemAssigned"
                },
                "local_auth_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "my-eventgrid-topic",
                "public_network_access_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 20,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}