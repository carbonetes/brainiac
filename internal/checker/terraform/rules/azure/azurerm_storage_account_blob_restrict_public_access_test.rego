package lib.terraform.CB_TFAZR_186

test_azurerm_storage_account_blob_restrict_public_access_passed {
    result := passed with input as [
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
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "allow_nested_items_to_be_public": false,
                "location": "azurerm_resource_group.example.location",
                "name": "storageaccountname",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "staging"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 17,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}

test_azurerm_storage_account_blob_restrict_public_access_failed {
    result := failed with input as [
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
                "endLine": 4,
                "startLine": 1
            }
        },
        {
            "Type": "resource",
            "Labels": [
                "azurerm_storage_account",
                "example"
            ],
            "Attributes": {
                "account_replication_type": "GRS",
                "account_tier": "Standard",
                "allow_nested_items_to_be_public": true,
                "location": "azurerm_resource_group.example.location",
                "name": "storageaccountname",
                "resource_group_name": "azurerm_resource_group.example.name",
                "tags": {
                    "environment": "staging"
                }
            },
            "Blocks": [],
            "line_range": {
                "endLine": 17,
                "startLine": 6
            }
        }
    ]
	count(result) == 1
}