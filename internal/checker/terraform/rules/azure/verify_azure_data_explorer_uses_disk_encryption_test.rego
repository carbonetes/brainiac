package lib.terraform.CB_TFAZR_039

test_azure_data_explorer_uses_disk_encryption_passed {
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
            "azurerm_kusto_cluster",
            "example"
        ],
        "Attributes": {
            "enable_disk_encryption": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_data_explorer_uses_disk_encryption_failed {
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
            "azurerm_kusto_cluster",
            "example"
        ],
        "Attributes": {
            "enable_disk_encryption": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 12,
            "startLine": 10
        }
    }]
	count(result) == 1
}
