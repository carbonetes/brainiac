package lib.terraform.CB_TFAZR_235

test_azure_pgsql_enables_customer_managed_key_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "ok"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "ok-resources"
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
            "azurerm_key_vault",
            "ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.ok.location",
            "name": "okkv",
            "purge_protection_enabled": true,
            "resource_group_name": "azurerm_resource_group.ok.name",
            "sku_name": "premium",
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 6
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
                "get",
                "unwrapkey",
                "wrapkey"
            ],
            "key_vault_id": "azurerm_key_vault.ok.id",
            "object_id": "azurerm_postgresql_server.ok.identity..principal_id",
            "secret_permissions": [
                "get"
            ],
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 21,
            "startLine": 15
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
                "get",
                "create",
                "delete",
                "list",
                "restore",
                "recover",
                "unwrapkey",
                "wrapkey",
                "purge",
                "encrypt",
                "decrypt",
                "sign",
                "verify"
            ],
            "key_vault_id": "azurerm_key_vault.ok.id",
            "object_id": "data.azurerm_client_config.current.object_id",
            "secret_permissions": [
                "get"
            ],
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 23
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_key_vault_key",
            "ok"
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
            "key_vault_id": "azurerm_key_vault.ok.id",
            "name": "tfex-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_postgresql_server",
            "ok"
        ],
        "Attributes": {
            "administrator_login": "acctestun",
            "administrator_login_password": "H@Sh1CoR3!",
            "location": "azurerm_resource_group.ok.location",
            "name": "ok-pg-server",
            "resource_group_name": "azurerm_resource_group.ok.name",
            "sku_name": "GP_Gen5_2",
            "ssl_enforcement_enabled": true,
            "ssl_minimal_tls_version_enforced": "TLS1_1",
            "storage_mb": "51200",
            "version": "5.6"
        },
        "Blocks": [
            {
                "Type": "identity",
                "Labels": [],
                "Attributes": {
                    "type": "SystemAssigned"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 57,
                    "startLine": 55
                }
            }
        ],
        "line_range": {
            "endLine": 58,
            "startLine": 43
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_postgresql_server_key",
            "ok"
        ],
        "Attributes": {
            "key_vault_key_id": "azurerm_key_vault_key.ok.id",
            "server_id": "azurerm_postgresql_server.ok.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 63,
            "startLine": 60
        }
    }
]
	count(result) == 1
}

test_azure_pgsql_enables_customer_managed_key_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "ok"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "ok-resources"
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
            "azurerm_key_vault",
            "ok"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.ok.location",
            "name": "okkv",
            "purge_protection_enabled": true,
            "resource_group_name": "azurerm_resource_group.ok.name",
            "sku_name": "premium",
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 13,
            "startLine": 6
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
                "get",
                "unwrapkey",
                "wrapkey"
            ],
            "key_vault_id": "azurerm_key_vault.ok.id",
            "object_id": "azurerm_postgresql_server.ok.identity..principal_id",
            "secret_permissions": [
                "get"
            ],
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 21,
            "startLine": 15
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
                "get",
                "create",
                "delete",
                "list",
                "restore",
                "recover",
                "unwrapkey",
                "wrapkey",
                "purge",
                "encrypt",
                "decrypt",
                "sign",
                "verify"
            ],
            "key_vault_id": "azurerm_key_vault.ok.id",
            "object_id": "data.azurerm_client_config.current.object_id",
            "secret_permissions": [
                "get"
            ],
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 23
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_key_vault_key",
            "ok"
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
            "key_vault_id": "azurerm_key_vault.ok.id",
            "name": "tfex-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 41,
            "startLine": 31
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_postgresql_server",
            "ok"
        ],
        "Attributes": {
            "administrator_login": "acctestun",
            "administrator_login_password": "H@Sh1CoR3!",
            "location": "azurerm_resource_group.ok.location",
            "name": "ok-pg-server",
            "resource_group_name": "azurerm_resource_group.ok.name",
            "sku_name": "GP_Gen5_2",
            "ssl_enforcement_enabled": true,
            "ssl_minimal_tls_version_enforced": "TLS1_1",
            "storage_mb": "51200",
            "version": "5.6"
        },
        "Blocks": [
            {
                "Type": "identity",
                "Labels": [],
                "Attributes": {
                    "type": "SystemAssigned"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 57,
                    "startLine": 55
                }
            }
        ],
        "line_range": {
            "endLine": 58,
            "startLine": 43
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_postgresql_server_key",
            "ok"
        ],
        "Attributes": {
            "key_vault_key_id": "",
            "server_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 63,
            "startLine": 60
        }
    }
]
	count(result) == 1
}