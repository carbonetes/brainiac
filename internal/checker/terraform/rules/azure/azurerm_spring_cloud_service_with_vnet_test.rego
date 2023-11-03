package lib.terraform.CB_TFAZR_219

test_azurerm_spring_cloud_service_with_vnet_passed {
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
                "azurerm_application_insights",
                "example"
            ],
            "Attributes": {
                "application_type": "web",
                "location": "azurerm_resource_group.example.location",
                "name": "tf-test-appinsights",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_spring_cloud_service",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-springcloud",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "S0",
                "tags": {
                    "Env": "staging"
                }
            },
            "Blocks": [
                {
                    "Type": "config_server_git_setting",
                    "Labels": [],
                    "Attributes": {
                        "label": "config",
                        "search_paths": [
                            "dir1",
                            "dir2"
                        ],
                        "uri": "https://github.com/Azure-Samples/piggymetrics"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "trace",
                    "Labels": [],
                    "Attributes": {
                        "connection_string": "azurerm_application_insights.example.connection_string",
                        "sample_rate": "10"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 32,
                        "startLine": 29
                    }
                },
                {
                    "Type": "network",
                    "Labels": [],
                    "Attributes": {
                        "app_subnet_id": "sample_app_subnet_id",
                        "cidr_range": [
                            "217.132.184.167",
                            "217.132.184.168"
                        ],
                        "service_runtime_subnet_id": "sample_service_runtime_subnet_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 43,
                        "startLine": 38
                    }
                }
            ],
            "line_range": {
                "endLine": 43,
                "startLine": 17
            }
        }
    ]
    count(result) == 1
}

test_azurerm_spring_cloud_service_with_vnet_failed {
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
                "azurerm_application_insights",
                "example"
            ],
            "Attributes": {
                "application_type": "web",
                "location": "azurerm_resource_group.example.location",
                "name": "tf-test-appinsights",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 15,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_spring_cloud_service",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-springcloud",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "B0",
                "tags": {
                    "Env": "staging"
                }
            },
            "Blocks": [
                {
                    "Type": "config_server_git_setting",
                    "Labels": [],
                    "Attributes": {
                        "label": "config",
                        "search_paths": [
                            "dir1",
                            "dir2"
                        ],
                        "uri": "https://github.com/Azure-Samples/piggymetrics"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 27,
                        "startLine": 23
                    }
                },
                {
                    "Type": "trace",
                    "Labels": [],
                    "Attributes": {
                        "connection_string": "azurerm_application_insights.example.connection_string",
                        "sample_rate": "10"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 32,
                        "startLine": 29
                    }
                },
                {
                    "Type": "network",
                    "Labels": [],
                    "Attributes": {
                        "app_subnet_id": "sample_app_subnet_id",
                        "cidr_range": [
                            "217.132.184.167",
                            "217.132.184.168"
                        ],
                        "service_runtime_subnet_id": "sample_service_runtime_subnet_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 43,
                        "startLine": 38
                    }
                }
            ],
            "line_range": {
                "endLine": 43,
                "startLine": 17
            }
        }
    ]
    count(result) == 1
}