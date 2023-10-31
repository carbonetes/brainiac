package lib.terraform.CB_TFAZR_167

test_azure_app_service_slot_min_tls_passed {
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
                    "min_tls_version": "1.2"
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

test_azure_app_service_slot_min_tls_failed {
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
                    "min_tls_version": "1.1"
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