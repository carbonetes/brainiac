package lib.terraform.CB_TFAZR_201

test_azurerm_servicebus_namespace_minimum_tls_version_passed {
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
                "name": "terraform-servicebus"
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
                "azurerm_servicebus_namespace",
                "example"
            ],
            "Attributes": {
                "minimum_tls_version": "1.2",
                "local_auth_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "tfex-servicebus-namespace",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard",
                "tags": {
                    "source": "terraform"
                }
            },
            "Blocks": [
                {
                    "Type": "customer_managed_key",
                    "Labels": [],
                    "Attributes": {
                        "identity_id": "sample_identity_id",
                        "key_vault_key_id": "sample_vault_key_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 25,
                        "startLine": 22
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 29,
                        "startLine": 27
                    }
                }
            ],
            "line_range": {
                "endLine": 30,
                "startLine": 10
            }
        }
    ]
    count(result) == 1
}

test_azurerm_servicebus_namespace_minimum_tls_version_failed {
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
                "name": "terraform-servicebus"
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
                "azurerm_servicebus_namespace",
                "example"
            ],
            "Attributes": {
                "minimum_tls_version": "1.1",
                "local_auth_enabled": false,
                "location": "azurerm_resource_group.example.location",
                "name": "tfex-servicebus-namespace",
                "resource_group_name": "azurerm_resource_group.example.name",
                "sku": "Standard",
                "tags": {
                    "source": "terraform"
                }
            },
            "Blocks": [
                {
                    "Type": "customer_managed_key",
                    "Labels": [],
                    "Attributes": {
                        "identity_id": "sample_identity_id",
                        "key_vault_key_id": "sample_vault_key_id"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 25,
                        "startLine": 22
                    }
                },
                {
                    "Type": "identity",
                    "Labels": [],
                    "Attributes": {
                        "type": "SystemAssigned"
                    },
                    "Blocks": [],
                    "line_range": {
                        "endLine": 29,
                        "startLine": 27
                    }
                }
            ],
            "line_range": {
                "endLine": 30,
                "startLine": 10
            }
        }
    ]
    count(result) == 1
}