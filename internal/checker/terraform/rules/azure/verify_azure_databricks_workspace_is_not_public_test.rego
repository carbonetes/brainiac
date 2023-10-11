package lib.terraform.CB_TFAZR_173

test_azure_databricks_workspace_is_not_public_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_databricks_workspace",
            "pass"
        ],
        "Attributes": {
            "public_network_access_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_databricks_workspace_is_not_public_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_databricks_workspace",
            "pass"
        ],
        "Attributes": {
            "public_network_access_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}