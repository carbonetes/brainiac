package lib.terraform.CB_TFAZR_174

test_azure_function_app_enable_logging_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_function_app_slot",
            "pass2"
        ],
        "Attributes": {
            "enable_builtin_logging": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_function_app_enable_logging_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_function_app_slot",
            "pass2"
        ],
        "Attributes": {
            "enable_builtin_logging": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}