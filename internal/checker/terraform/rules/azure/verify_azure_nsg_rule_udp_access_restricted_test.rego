package lib.terraform.CB_TFAZR_044

test_azure_nsg_rule_udp_access_restricted_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_network_security_group",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "security_rule",
                "Labels": [],
                "Attributes": {
                    "access": "Deny",
                    "destination_address_prefix": "*",
                    "destination_port_range": "*",
                    "direction": "Inbound",
                    "name": "test123",
                    "priority": "100",
                    "protocol": "Udp",
                    "source_address_prefix": "*",
                    "source_port_range": "*"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 22,
            "startLine": 10
        }
    }]
	count(result) == 1
}

test_azure_nsg_rule_udp_access_restricted_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_network_security_group",
            "example"
        ],
        "Attributes": {},
        "Blocks": [
            {
                "Type": "security_rule",
                "Labels": [],
                "Attributes": {
                    "access": "Allow",
                    "destination_address_prefix": "*",
                    "destination_port_range": "*",
                    "direction": "Inbound",
                    "name": "test123",
                    "priority": "100",
                    "protocol": "Udp",
                    "source_address_prefix": "*",
                    "source_port_range": "*"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 21,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 22,
            "startLine": 10
        }
    }]
	count(result) == 1
}
