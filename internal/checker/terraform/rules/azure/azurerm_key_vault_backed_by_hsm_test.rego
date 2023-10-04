package lib.terraform.CB_TFAZR_111

test_azurerm_key_vault_backed_by_hsm_passed {
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
                                "purge_soft_deleted_keys_on_destroy": true,
                                "recover_soft_deleted_keys": true
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
                            "Delete",
                            "Get",
                            "Purge",
                            "Recover",
                            "Update",
                            "GetRotationPolicy",
                            "SetRotationPolicy"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Set"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 43,
                        "startLine": 25
                    }
                }
            ],
            "line_range": {
                "endLine": 44,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_key",
                "generated"
            ],
            "Attributes": {
                "key_opts": [
                    "decrypt",
                    "encrypt",
                    "sign",
                    "unwrapKey",
                    "verify",
                    "wrapKey"
                ],
                "key_size": "2048",
                "key_type": "RSA-HSM",
                "key_vault_id": "azurerm_key_vault.example.id",
                "name": "generated-certificate"
            },
            "Blocks": [
                {
                    "Type": "rotation_policy",
                    "Labels": [],
                    "Attributes": {
                        "expire_after": "P90D",
                        "notify_before_expiry": "P29D"
                    },
                    "Blocks": [
                        {
                            "Type": "automatic",
                            "Labels": [],
                            "Attributes": {
                                "time_before_expiry": "P30D"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 64,
                                "startLine": 62
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 68,
                        "startLine": 61
                    }
                }
            ],
            "line_range": {
                "endLine": 69,
                "startLine": 46
            }
        }
    ]

    count(result) == 1
}

test_azurerm_key_vault_backed_by_hsm_failed {
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
                                "purge_soft_deleted_keys_on_destroy": true,
                                "recover_soft_deleted_keys": true
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
                            "Delete",
                            "Get",
                            "Purge",
                            "Recover",
                            "Update",
                            "GetRotationPolicy",
                            "SetRotationPolicy"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "Set"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 43,
                        "startLine": 25
                    }
                }
            ],
            "line_range": {
                "endLine": 44,
                "startLine": 17
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_key",
                "generated"
            ],
            "Attributes": {
                "key_opts": [
                    "decrypt",
                    "encrypt",
                    "sign",
                    "unwrapKey",
                    "verify",
                    "wrapKey"
                ],
                "key_size": "2048",
                "key_type": "RSA",
                "key_vault_id": "azurerm_key_vault.example.id",
                "name": "generated-certificate"
            },
            "Blocks": [
                {
                    "Type": "rotation_policy",
                    "Labels": [],
                    "Attributes": {
                        "expire_after": "P90D",
                        "notify_before_expiry": "P29D"
                    },
                    "Blocks": [
                        {
                            "Type": "automatic",
                            "Labels": [],
                            "Attributes": {
                                "time_before_expiry": "P30D"
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 64,
                                "startLine": 62
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 68,
                        "startLine": 61
                    }
                }
            ],
            "line_range": {
                "endLine": 69,
                "startLine": 46
            }
        }
    ]

    count(result) == 1
}
