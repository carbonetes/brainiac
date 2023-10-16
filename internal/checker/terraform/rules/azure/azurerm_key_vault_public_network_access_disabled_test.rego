package lib.terraform.CB_TFAZR_184 

test_azurerm_key_vault_public_network_access_disabled_passed {
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
                                "endLine": 7,
                                "startLine": 4
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 8,
                        "startLine": 3
                    }
                }
            ],
            "line_range": {
                "endLine": 9,
                "startLine": 2
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
                "endLine": 11,
                "startLine": 11
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
                "endLine": 16,
                "startLine": 13
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
                "public_network_access_enabled": true,
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
                        "ip_rules": [
                            "205.141.289.101",
                            "205.141.289.102"
                        ]
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 35,
                        "startLine": 30
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
                        "endLine": 52,
                        "startLine": 37
                    }
                }
            ],
            "line_range": {
                "endLine": 53,
                "startLine": 18
            }
        }
    ]
	count(result) == 1
}

test_azurerm_key_vault_public_network_access_disabled_failed {
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
                                "endLine": 7,
                                "startLine": 4
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 8,
                        "startLine": 3
                    }
                }
            ],
            "line_range": {
                "endLine": 9,
                "startLine": 2
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
                "endLine": 11,
                "startLine": 11
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
                "endLine": 16,
                "startLine": 13
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
                "public_network_access_enabled": true,
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
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 35,
                        "startLine": 30
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
                        "endLine": 52,
                        "startLine": 37
                    }
                }
            ],
            "line_range": {
                "endLine": 53,
                "startLine": 18
            }
        }
    ]
	count(result) == 1
}
