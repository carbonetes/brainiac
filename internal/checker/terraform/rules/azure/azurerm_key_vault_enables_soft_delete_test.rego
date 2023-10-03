package lib.terraform.CB_TFAZR_110

test_azurerm_key_vault_enables_soft_delete_passed {
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
                                "purge_soft_delete_on_destroy": true
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 5,
                                "startLine": 3
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 6,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 7,
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
                "endLine": 9,
                "startLine": 9
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West US",
                "name": "resourceGroup1"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 11
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
                "name": "testvault",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_enabled": true,
                "soft_delete_retention_days": "7",
                "tags": {
                    "environment": "Testing"
                },
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "get",
                            "ManageContacts"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "get"
                        ],
                        "storage_permissions": [
                            "get"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 44,
                        "startLine": 28
                    }
                },
                {
                    "Type": "network_acls",
                    "Labels": [],
                    "Attributes": {
                        "bypass": "AzureServices",
                        "default_action": "Deny"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 49,
                        "startLine": 46
                    }
                },
                {
                    "Type": "contact",
                    "Labels": [],
                    "Attributes": {
                        "email": "example@example.com",
                        "name": "example",
                        "phone": "0123456789"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 55,
                        "startLine": 51
                    }
                }
            ],
            "line_range": {
                "endLine": 60,
                "startLine": 16
            }
        }
    ]
    count(result) == 1
}


test_azurerm_key_vault_enables_soft_delete_failed {
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
                                "purge_soft_delete_on_destroy": true
                            },
                            "Blocks": [],
                            "line_range": {
                                "endLine": 5,
                                "startLine": 3
                            }
                        }
                    ],
                    "line_range": {
                        "endLine": 6,
                        "startLine": 2
                    }
                }
            ],
            "line_range": {
                "endLine": 7,
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
                "endLine": 9,
                "startLine": 9
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_resource_group",
                "example"
            ],
            "Attributes": {
                "location": "West US",
                "name": "resourceGroup1"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 14,
                "startLine": 11
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
                "name": "testvault",
                "purge_protection_enabled": false,
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku_name": "standard",
                "soft_delete_enabled": false,
                "soft_delete_retention_days": "7",
                "tags": {
                    "environment": "Testing"
                },
                "tenant_id": "data.azurerm_client_config.current.tenant_id"
            },
            "Blocks": [
                {
                    "Type": "access_policy",
                    "Labels": [],
                    "Attributes": {
                        "key_permissions": [
                            "get",
                            "ManageContacts"
                        ],
                        "object_id": "data.azurerm_client_config.current.object_id",
                        "secret_permissions": [
                            "get"
                        ],
                        "storage_permissions": [
                            "get"
                        ],
                        "tenant_id": "data.azurerm_client_config.current.tenant_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 44,
                        "startLine": 28
                    }
                },
                {
                    "Type": "network_acls",
                    "Labels": [],
                    "Attributes": {
                        "bypass": "AzureServices",
                        "default_action": "Deny"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 49,
                        "startLine": 46
                    }
                },
                {
                    "Type": "contact",
                    "Labels": [],
                    "Attributes": {
                        "email": "example@example.com",
                        "name": "example",
                        "phone": "0123456789"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 55,
                        "startLine": 51
                    }
                }
            ],
            "line_range": {
                "endLine": 60,
                "startLine": 16
            }
        }
    ]
    count(result) == 1
}