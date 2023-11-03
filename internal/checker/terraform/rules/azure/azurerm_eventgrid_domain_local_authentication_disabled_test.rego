package lib.terraform.CB_TFAZR_191

test_azurerm_eventgrid_domain_local_authentication_disabled_passed {
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
                "azurerm_eventgrid_domain",
                "example"
            ],
            "Attributes": {
                "local_auth_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "my-eventgrid-domain",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
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

test_azurerm_eventgrid_domain_local_authentication_disabled_failed {
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
                "azurerm_eventgrid_domain",
                "example"
            ],
            "Attributes": {
                "local_auth_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "my-eventgrid-domain",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "Production"
                }
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