package lib.terraform.CB_TFAZR_188

test_azurerm_eventgrid_topic_identity_provider_enabled_passed {
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
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}

test_azurerm_eventgrid_topic_identity_provider_enabled_failed {
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
                "local_auth_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "my-eventgrid-topic",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 18,
                "startLine": 6
            }
        }
    ]
    count(result) == 1
}