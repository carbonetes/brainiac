package lib.terraform.CB_TFAZR_239

test_azure_cognitive_services_customer_managed_key_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_cognitive_account",
            "cognitive_account_good"
        ],
        "Attributes": {
            "kind": "Face",
            "location": "azurerm_resource_group.example.location",
            "name": "example-account",
            "public_network_access_enabled": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku_name": "E0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_key_vault",
            "good_vault"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.example.location",
            "name": "example-vault",
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku_name": "standard",
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
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
            "azurerm_key_vault_key",
            "good_key"
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
            "key_vault_id": "azurerm_key_vault.good_vault.id",
            "name": "example-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_cognitive_account_customer_managed_key",
            "good_cmk"
        ],
        "Attributes": {
            "cognitive_account_id": "azurerm_cognitive_account.cognitive_account_good.id",
            "key_vault_key_id": "azurerm_key_vault_key.good_key.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 26
        }
    }
]
	count(result) == 1
}

test_azure_cognitive_services_customer_managed_key_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_cognitive_account",
            "cognitive_account_good"
        ],
        "Attributes": {
            "kind": "Face",
            "location": "azurerm_resource_group.example.location",
            "name": "example-account",
            "public_network_access_enabled": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku_name": "E0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_key_vault",
            "good_vault"
        ],
        "Attributes": {
            "location": "azurerm_resource_group.example.location",
            "name": "example-vault",
            "resource_group_name": "azurerm_resource_group.example.name",
            "sku_name": "standard",
            "tenant_id": "data.azurerm_client_config.current.tenant_id"
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
            "azurerm_key_vault_key",
            "good_key"
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
            "key_vault_id": "azurerm_key_vault.good_vault.id",
            "name": "example-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 24,
            "startLine": 18
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_cognitive_account_customer_managed_key",
            "good_cmk"
        ],
        "Attributes": {
            "cognitive_account_id": "",
            "key_vault_key_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 29,
            "startLine": 26
        }
    }
]
	count(result) == 1
}