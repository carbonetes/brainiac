package lib.terraform.CB_TFAZR_154

test_azure_api_management_certs_enforced_passed {
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
            "azurerm_api_management",
            "pass"
        ],
        "Attributes": {
            "client_cert_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_api_management_certs_enforced_failed {
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
            "azurerm_api_management",
            "pass"
        ],
        "Attributes": {
            "client_cert_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 5
        }
    }]
	count(result) == 1
}