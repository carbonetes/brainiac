package lib.terraform.CB_TFAZR_211

test_azurerm_app_service_set_health_check_passed {
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
                    "Type": "site_config",
                    "Labels": [],
                    "Attributes": {
                        "dotnet_framework_version": "v4.0",
                        "health_check_path": "sample_health_check_path",
                        "scm_type": "LocalGit"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "connection_string",
                    "Labels": [],
                    "Attributes": {
                        "name": "Database",
                        "type": "SQLServer",
                        "value": "Server=some-server.mydomain.com;Integrated Security=SSPI"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 37,
                        "startLine": 33
                    }
                }
            ],
            "line_range": {
                "endLine": 38,
                "startLine": 17
            }
        }
    ]
	count(result) == 1
}

test_azurerm_app_service_set_health_check_failed {
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
                    "Type": "site_config",
                    "Labels": [],
                    "Attributes": {
                        "dotnet_framework_version": "v4.0",
                        "scm_type": "LocalGit"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "connection_string",
                    "Labels": [],
                    "Attributes": {
                        "name": "Database",
                        "type": "SQLServer",
                        "value": "Server=some-server.mydomain.com;Integrated Security=SSPI"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 37,
                        "startLine": 33
                    }
                }
            ],
            "line_range": {
                "endLine": 38,
                "startLine": 17
            }
        }
    ]
	count(result) == 1
}
