package lib.terraform.CB_TFAZR_041

test_azure_batch_account_uses_key_vault_encryption_passed {
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
            "azurerm_batch_account",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "key_vault_reference",
                "Labels": [],
                "Attributes": {
                    "id": "test",
                    "url": "https://test.com"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_batch_account_uses_key_vault_encryption_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_batch_account",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "key_vault_reference",
                "Labels": [],
                "Attributes": {
                    "id": "",
                    "url": "https://test.com"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 14,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 15,
            "startLine": 10
        }
    }]
	count(result) == 1
}