package lib.terraform.CB_TFAZR_022

test_verify_azure_instance_extensions_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_linux_virtual_machine",
            "example"
        ],
        "Attributes": {
            "allow_extension_operations": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_verify_azure_instance_extensions_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_linux_virtual_machine",
            "example"
        ],
        "Attributes": {
            "allow_extension_operations": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}
