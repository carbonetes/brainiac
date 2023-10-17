package lib.terraform.CB_TFAZR_185

test_azure_acr_enable_image_quarantine_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "acr"
        ],
        "Attributes": {
            "quarantine_policy_enabled": true
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

test_azure_acr_enable_image_quarantine_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "acr"
        ],
        "Attributes": {
            "quarantine_policy_enabled": false
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