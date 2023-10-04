package lib.terraform.CB_TFAZR_107

test_azurerm_iothub_no_public_network_access_passed {
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
                    "Blocks": [
                        {
                            "Type": "key_vault",
                            "Labels": [],
                            "Attributes": {
                                "purge_soft_delete_on_destroy": true,
                                "recover_soft_deleted_key_vaults": true
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 6,
                                "startLine": 3
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 7,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        },
        {
            "Type": "data",
            "Labels": [
                "azurerm_client_config",
                "current"
            ],
            "Attributes": {},
            "Blocks": [],
            "line_range": {
                "endLine": 10,
                "startLine": 10
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
                "endLine": 15,
                "startLine": 12
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault",
                "example"
            ],
            "Attributes": {
                "enabled_for_disk_encryption": true,
                "location": "azurerm_resource_group.example.location",
                "name": "examplekeyvault",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "network_acls",
                    "Labels": [],
                    "Attributes": {
                        "bypass": "AzureServices",
                        "default_action": "Deny"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 29,
                        "startLine": 26
                    }
                },
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "Get"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Get"
                        ],
                        "storage_permissions": [
                            "Get"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 48,
                        "startLine": 33
                    }
                }
            ],
            "line_range": {
                "endLine": 49,
                "startLine": 17
            }
        }
    ]
    count(result) == 1
}

test_azurerm_iothub_no_public_network_access_failed {
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
                    "Blocks": [
                        {
                            "Type": "key_vault",
                            "Labels": [],
                            "Attributes": {
                                "purge_soft_delete_on_destroy": true,
                                "recover_soft_deleted_key_vaults": true
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 6,
                                "startLine": 3
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 7,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        },
        {
            "Type": "data",
            "Labels": [
                "azurerm_client_config",
                "current"
            ],
            "Attributes": {},
            "Blocks": [],
            "line_range": {
                "endLine": 10,
                "startLine": 10
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
                "endLine": 15,
                "startLine": 12
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault",
                "example"
            ],
            "Attributes": {
                "enabled_for_disk_encryption": true,
                "location": "azurerm_resource_group.example.location",
                "name": "examplekeyvault",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "network_acls",
                    "Labels": [],
                    "Attributes": {
                        "bypass": "AzureServices",
                        "default_action": "Allow"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 29,
                        "startLine": 26
                    }
                },
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "Get"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Get"
                        ],
                        "storage_permissions": [
                            "Get"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 48,
                        "startLine": 33
                    }
                }
            ],
            "line_range": {
                "endLine": 49,
                "startLine": 17
            }
        }
    ]
    count(result) == 1
}