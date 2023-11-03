package lib.terraform.CB_TFAZR_005

test_azure_keyvault_recovery_enabled {
	result := passed with input as [{
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
            "location": "East US",
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
            "azurerm_key_vault",
            "example"
        ],
        "Attributes": {
            "enabled_for_disk_encryption": true,
            "enabled_for_template_deployment": true,
            "location": "azurerm_resource_group.example.location",
            "name": "examplekeyvault",
            "purge_protection_enabled": true,
            "resource_group_name": "azurerm_resource_group.example.name",
            "soft_delete_enabled": true,
            "tenant_id": "YOUR_TENANT_ID"
        },
        "Blocks": [
            {
                "Type": "sku",
                "Labels": [],
                "Attributes": {
                    "name": "standard"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 17
                }
            },
            {
                "Type": "access_policy",
                "Labels": [],
                "Attributes": {
                    "certificate_permissions": [
                        "get",
                        "create",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "key_permissions": [
                        "get",
                        "create",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "object_id": "YOUR_OBJECT_ID",
                    "secret_permissions": [
                        "get",
                        "set",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "tenant_id": "YOUR_TENANT_ID"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 23
                }
            }
        ],
        "line_range": {
            "endLine": 57,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_keyvault_recovery_disabled {
	result := failed with input as [{
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
            "location": "East US",
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
            "azurerm_key_vault",
            "example"
        ],
        "Attributes": {
            "enabled_for_disk_encryption": true,
            "enabled_for_template_deployment": true,
            "location": "azurerm_resource_group.example.location",
            "name": "examplekeyvault",
            "purge_protection_enabled": false,
            "resource_group_name": "azurerm_resource_group.example.name",
            "soft_delete_enabled": false,
            "tenant_id": "YOUR_TENANT_ID"
        },
        "Blocks": [
            {
                "Type": "sku",
                "Labels": [],
                "Attributes": {
                    "name": "standard"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 19,
                    "startLine": 17
                }
            },
            {
                "Type": "access_policy",
                "Labels": [],
                "Attributes": {
                    "certificate_permissions": [
                        "get",
                        "create",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "key_permissions": [
                        "get",
                        "create",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "object_id": "YOUR_OBJECT_ID",
                    "secret_permissions": [
                        "get",
                        "set",
                        "delete",
                        "list",
                        "recover",
                        "purge"
                    ],
                    "tenant_id": "YOUR_TENANT_ID"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 53,
                    "startLine": 23
                }
            }
        ],
        "line_range": {
            "endLine": 57,
            "startLine": 10
        }
    }]
	count(result) == 1
}
