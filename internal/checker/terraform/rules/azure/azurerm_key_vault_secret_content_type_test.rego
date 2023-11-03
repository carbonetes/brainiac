package lib.terraform.CB_TFAZR_115

test_azurerm_key_vault_secret_content_type_passed {
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
                                "purge_soft_deleted_secrets_on_destroy": true,
                                "recover_soft_deleted_secrets": true
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
                "location": "azurerm_resource_group.example.location",
                "name": "examplekeyvault",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "premium",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "Create",
                            "Get"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Set",
                            "Get",
                            "Delete",
                            "Purge",
                            "Recover"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 41,
                        "startLine": 25
                    }
                }
            ],
            "line_range": {
                "endLine": 42,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_secret",
                "example"
            ],
            "Attributes": {
                "content_type": "sample_content_type",
                "key_vault_id": "azurerm_key_vault.example.id",
                "name": "secret-sauce",
                "value": "szechuan"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 49,
                "startLine": 44
            }
        }
    ]
    
	count(result) == 1
}

test_azurerm_key_vault_secret_content_type_failed {
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
                                "purge_soft_deleted_secrets_on_destroy": true,
                                "recover_soft_deleted_secrets": true
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
                "location": "azurerm_resource_group.example.location",
                "name": "examplekeyvault",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "premium",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "Create",
                            "Get"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Set",
                            "Get",
                            "Delete",
                            "Purge",
                            "Recover"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 41,
                        "startLine": 25
                    }
                }
            ],
            "line_range": {
                "endLine": 42,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_secret",
                "example"
            ],
            "Attributes": {
                "key_vault_id": "azurerm_key_vault.example.id",
                "name": "secret-sauce",
                "value": "szechuan"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 49,
                "startLine": 44
            }
        }
    ]
	count(result) == 1
}