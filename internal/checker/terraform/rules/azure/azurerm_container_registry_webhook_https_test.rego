package lib.terraform.CB_TFAZR_228

test_azurerm_container_registry_webhook_https_passed {
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
                "azurerm_container_registry",
                "acr"
            ],
            "Attributes": {
                "admin_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "containerRegistry1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_container_registry_webhook",
                "webhook"
            ],
            "Attributes": {
                "actions": [
                    "push"
                ],
                "custom_headers": {
                    "Content-Type": "application/json"
                },
                "location": "azurerm_resource_group.example.location",
                "name": "mywebhook",
                "registry_name": "azurerm_container_registry.acr.name",
                "resource_group_name": "azurerm_resource_group.example.name",
                "scope": "mytag:*",
                "service_uri": "https://mywebhookreceiver.example/mytag",
                "status": "enabled"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 27,
                "startLine": 14
            }
        }
    ]
    count(result) == 1
}

test_azurerm_container_registry_webhook_https_failed {
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
                "azurerm_container_registry",
                "acr"
            ],
            "Attributes": {
                "admin_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "containerRegistry1",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_container_registry_webhook",
                "webhook"
            ],
            "Attributes": {
                "actions": [
                    "push"
                ],
                "custom_headers": {
                    "Content-Type": "application/json"
                },
                "location": "azurerm_resource_group.example.location",
                "name": "mywebhook",
                "registry_name": "azurerm_container_registry.acr.name",
                "resource_group_name": "azurerm_resource_group.example.name",
                "scope": "mytag:*",
                "service_uri": "http://mywebhookreceiver.example/mytag",
                "status": "enabled"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 27,
                "startLine": 14
            }
        }
    ]
    count(result) == 1
}