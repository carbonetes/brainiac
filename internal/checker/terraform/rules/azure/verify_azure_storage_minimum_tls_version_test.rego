package lib.terraform.CB_TFAZR_012

test_aazure_storage_minimum_tls_version_passed {
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
            "azurerm_storage_account",
            "example"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "enable_https_traffic_only": true,
            "location": "azurerm_resource_group.example.location",
            "min_tls_version": "TLS1_2",
            "name": "mystorageaccount",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_storage_minimum_tls_version_failed {
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
            "azurerm_storage_account",
            "example"
        ],
        "Attributes": {
            "account_replication_type": "LRS",
            "account_tier": "Standard",
            "enable_https_traffic_only": true,
            "location": "azurerm_resource_group.example.location",
            "min_tls_version": "TLS1_0",
            "name": "mystorageaccount",
            "resource_group_name": "azurerm_resource_group.example.name"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 19,
            "startLine": 10
        }
    }]
	count(result) == 1
}
