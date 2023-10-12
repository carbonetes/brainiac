package lib.terraform.CB_TFAZR_175

test_azure_nsg_rule_http_access_restricted_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_network_security_rule",
            "https"
        ],
        "Attributes": {
            "destination_port_range": "443"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_nsg_rule_http_access_restricted_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_network_security_rule",
            "https"
        ],
        "Attributes": {
            "destination_port_range": "80"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 3,
            "startLine": 1
        }
    }]
	count(result) == 1
}