package lib.terraform.CB_TFAZR_165

test_azurerm_app_configuration_encryption_is_set_passed {
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
                            "Type": "app_configuration",
                            "Labels": [],
                            "Attributes": {
                                "purge_soft_delete_on_destroy": true,
                                "recover_soft_deleted": true
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
                "endLine": 13,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_user_assigned_identity",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-identity",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 19,
                "startLine": 15
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
                "endLine": 21,
                "startLine": 21
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
                "name": "exampleKVt123",
                "purge_protection_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 31,
                "startLine": 23
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_access_policy",
                "server"
            ],
            "Attributes": {
                "key_permissions": [
                    "Get",
                    "UnwrapKey",
                    "WrapKey"
                ],
                "key_vault_id": "azurerm_key_vault.example.id",
                "object_id": "azurerm_user_assigned_identity.example.principal_id",
                "secret_permissions": [
                    "Get"
                ],
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 40,
                "startLine": 33
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_access_policy",
                "client"
            ],
            "Attributes": {
                "key_permissions": [
                    "Get",
                    "Create",
                    "Delete",
                    "List",
                    "Restore",
                    "Recover",
                    "UnwrapKey",
                    "WrapKey",
                    "Purge",
                    "Encrypt",
                    "Decrypt",
                    "Sign",
                    "Verify",
                    "GetRotationPolicy"
                ],
                "key_vault_id": "azurerm_key_vault.example.id",
                "object_id": "data.azurerm_client_config.current.object_id",
                "secret_permissions": [
                    "Get"
                ],
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 49,
                "startLine": 42
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_key",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_key_vault_access_policy.client",
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
                "name": "exampleKVkey"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 69,
                "startLine": 51
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_app_configuration",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_key_vault_access_policy.client",
                "local_auth_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "appConf2",
                "public_network_access": "Enabled",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard",
                "soft_delete_retention_days": "1",
                "tags": {
                    "environment": "development"
                }
            },
            "Blocks": [
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "identity_ids": "azurerm_user_assigned_identity.example.id",
                        "type": "UserAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 86,
                        "startLine": 81
                    }
                },
                {
                    "Type": "encryption",
                    "Labels": [],
                    "Attributes": {
                        "identity_client_id": "azurerm_user_assigned_identity.example.client_id",
                        "key_vault_key_identifier": "azurerm_key_vault_key.example.id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 91,
                        "startLine": 88
                    }
                },
                {
                    "Type": "replica",
                    "Labels": [],
                    "Attributes": {
                        "location": "West US",
                        "name": "replica1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 96,
                        "startLine": 93
                    }
                }
            ],
            "line_range": {
                "endLine": 106,
                "startLine": 71
            }
        }
    ]
    count(result) == 1
}

test_azurerm_app_configuration_encryption_is_set_failed {
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
                            "Type": "app_configuration",
                            "Labels": [],
                            "Attributes": {
                                "purge_soft_delete_on_destroy": true,
                                "recover_soft_deleted": true
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
                "endLine": 13,
                "startLine": 10
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_user_assigned_identity",
                "example"
            ],
            "Attributes": {
                "location": "azurerm_resource_group.example.location",
                "name": "example-identity",
                "resource_group_name": "azurerm_resource_group.example.name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 19,
                "startLine": 15
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
                "endLine": 21,
                "startLine": 21
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
                "name": "exampleKVt123",
                "purge_protection_enabled": true,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_retention_days": "7",
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 31,
                "startLine": 23
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_access_policy",
                "server"
            ],
            "Attributes": {
                "key_permissions": [
                    "Get",
                    "UnwrapKey",
                    "WrapKey"
                ],
                "key_vault_id": "azurerm_key_vault.example.id",
                "object_id": "azurerm_user_assigned_identity.example.principal_id",
                "secret_permissions": [
                    "Get"
                ],
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 40,
                "startLine": 33
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_access_policy",
                "client"
            ],
            "Attributes": {
                "key_permissions": [
                    "Get",
                    "Create",
                    "Delete",
                    "List",
                    "Restore",
                    "Recover",
                    "UnwrapKey",
                    "WrapKey",
                    "Purge",
                    "Encrypt",
                    "Decrypt",
                    "Sign",
                    "Verify",
                    "GetRotationPolicy"
                ],
                "key_vault_id": "azurerm_key_vault.example.id",
                "object_id": "data.azurerm_client_config.current.object_id",
                "secret_permissions": [
                    "Get"
                ],
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 49,
                "startLine": 42
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault_key",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_key_vault_access_policy.client",
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
                "name": "exampleKVkey"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 69,
                "startLine": 51
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_app_configuration",
                "example"
            ],
            "Attributes": {
                "depends_on": "azurerm_key_vault_access_policy.client",
                "local_auth_enabled": true,
                "location": "azurerm_resource_group.example.location",
                "name": "appConf2",
                "public_network_access": "Enabled",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "standard",
                "soft_delete_retention_days": "1",
                "tags": {
                    "environment": "development"
                }
            },
            "Blocks": [
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "identity_ids": "azurerm_user_assigned_identity.example.id",
                        "type": "UserAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 86,
                        "startLine": 81
                    }
                },
                {
                    "Type": "encryption",
                    "Labels": [],
                    "Attributes": {
                        "identity_client_id": "azurerm_user_assigned_identity.example.client_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 91,
                        "startLine": 88
                    }
                },
                {
                    "Type": "replica",
                    "Labels": [],
                    "Attributes": {
                        "location": "West US",
                        "name": "replica1"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 96,
                        "startLine": 93
                    }
                }
            ],
            "line_range": {
                "endLine": 106,
                "startLine": 71
            }
        }
    ]
    count(result) == 1
}