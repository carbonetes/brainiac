package lib.terraform.CB_TFAZR_232

test_azurerm_key_vault_config_private_endpoint_passed {
	result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_private_endpoint",
                "example"
            ],
            "Attributes": {
                "location": "East US",
                "name": "private-endpoint",
                "resource_group_name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "name": "examplestor",
                "resource_group_name": "azurerm_private_endpoint.example.resource_group_name"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 7
            }
        }
    ]
    count(result) == 1
}

test_azurerm_key_vault_config_private_endpoint_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_private_endpoint",
                "example"
            ],
            "Attributes": {
                "location": "East US",
                "name": "private-endpoint",
                "resource_group_name": "example-resources"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 5,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_key_vault",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "name": "examplestor"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 12,
                "startLine": 7
            }
        }
    ]
    count(result) == 1
}