package lib.terraform.CB_TFAZR_171

test_azure_synapse_workspace_enables_data_exfill_protection_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_workspace",
            "pass"
        ],
        "Attributes": {
            "data_exfiltration_protection_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_synapse_workspace_enables_data_exfill_protection_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_workspace",
            "pass"
        ],
        "Attributes": {
            "data_exfiltration_protection_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}