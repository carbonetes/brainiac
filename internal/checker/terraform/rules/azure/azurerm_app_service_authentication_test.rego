package lib.terraform.CB_TFAZR_045

test_azurerm_app_service_authentication_passed {
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
                "azurerm_app_service_plan",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-appserviceplan",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "size": "S1",
                        "tier": "Standard"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_app_service",
                "example"
            ],
            "Attributes": {
                "app_service_plan_id": "azurerm_app_service_plan.example.id",
                "app_settings": {
                    "SOME_KEY": "some-value"
                },
                "location": "azurerm_resource_group.example.location",
                "name": "example-app-service",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "auth_settings_v2",
                    "Labels": [],
                    "Attributes": {
                        "auth_enabled": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 24
                    }
                }
            ],
            "Blocks": [
                {
                    "Type": "auth_settings",
                    "Labels": [],
                    "Attributes": {
                        "enabled": true
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 24
                    }
                }
            ],
            "line_range": {
                "endLine": 37,
                "startLine": 17
            }
        }
    ]
	count(result) == 1
}

test_azurerm_app_service_authentication_failed {
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
                "azurerm_app_service_plan",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-appserviceplan",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "sku",
                    "Labels": [],
                    "Attributes": {
                        "size": "S1",
                        "tier": "Standard"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 14,
                        "startLine": 11
                    }
                }
            ],
            "line_range": {
                "endLine": 15,
                "startLine": 6
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_app_service",
                "example"
            ],
            "Attributes": {
                "app_service_plan_id": "azurerm_app_service_plan.example.id",
                "app_settings": {
                    "SOME_KEY": "some-value"
                },
                "location": "azurerm_resource_group.example.location",
                "name": "example-app-service",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [
                {
                    "Type": "auth_settings_v2",
                    "Labels": [],
                    "Attributes": {
                        "auth_enabled": false
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 24
                    }
                }
            ],
            "line_range": {
                "endLine": 37,
                "startLine": 17
            }
        }
    ]
	count(result) == 1
}