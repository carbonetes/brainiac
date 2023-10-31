package lib.terraform.CB_TFAZR_159

test_azure_app_service_slot_https_only_passed {
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
            "azurerm_app_service_slot",
            "pass"
        ],
        "Attributes": {
            "https_only": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_app_service_slot_https_only_failed {
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
            "azurerm_app_service_slot",
            "pass"
        ],
        "Attributes": {
            "https_only": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}