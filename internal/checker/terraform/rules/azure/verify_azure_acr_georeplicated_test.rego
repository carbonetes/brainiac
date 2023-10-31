package lib.terraform.CB_TFAZR_182

test_azure_acr_georeplicated_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "acr"
        ],
        "Attributes": {
            "sku": "Premium"
        },
        "Blocks": [
            {
                "Type": "georeplications",
                "Labels": [],
                "Attributes": {
                    "location": "East US",
                    "zone_redundancy_enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_acr_georeplicated_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "acr"
        ],
        "Attributes": {
            "sku": "Basic"
        },
        "Blocks": [
            {
                "Type": "notgeoreplications",
                "Labels": [],
                "Attributes": {
                    "location": "East US",
                    "zone_redundancy_enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 7,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    }]
	count(result) == 1
}