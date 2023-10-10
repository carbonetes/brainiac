package lib.terraform.CB_TFAZR_169

test_azure_app_service_slot_debug_disabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_app_service_slot",
            "pass2"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "remote_debugging_enabled": false
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_app_service_slot_debug_disabled_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_app_service_slot",
            "pass2"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "site_config",
                "Labels": [],
                "Attributes": {
                    "remote_debugging_enabled": true
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 5,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}