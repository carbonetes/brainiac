package lib.terraform.CB_TFAZR_045

test_azurerm_app_service_passed {
	result := passed with input as [
        {
            "Type": "provider",
            "Labels": [
                "azurerm"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "features",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 2,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        },
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
                "endLine": 8,
                "startLine": 5
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_service_plan",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "os_type": "Linux",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "P1v2"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_linux_web_app",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_service_plan.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name",
                "service_plan_id": "azurerm_service_plan.example.id"
            },
            "Blocks": [
                {
                    "Type": "site_config",
                    "Labels": [],
                    "Attributes": {},
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
                "endLine": 25,
                "startLine": 18
            }
        }
    ]
	count(result) == 1
}

test_azurerm_app_service_failed {
	result := failed with input as [
        {
            "Type": "provider",
            "Labels": [
                "azurerm"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "features",
                    "Labels": [],
                    "Attributes": {},
                    "Blocks": [],
                    "line_range": {
                        "endLine": 2,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        },
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
                "endLine": 8,
                "startLine": 5
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_service_plan",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example",
                "os_type": "Linux",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "P1v2"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 16,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_linux_web_app",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_service_plan.example.location",
                "name": "example",
                "resource_group_name": "azurerm_resource_group.example.name",
                "service_plan_id": "azurerm_service_plan.example.id"
            },
            "Blocks": [
                {
                    "Type": "site_config",
                    "Labels": [],
                    "Blocks": [],
                    "line_range": {
                        "endLine": 24,
                        "startLine": 24
                    }
                }
            ],
            "line_range": {
                "endLine": 25,
                "startLine": 18
            }
        }
    ]
	count(result) == 1
}