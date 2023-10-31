package lib.terraform.CB_TFAZR_181

test_azure_acr_container_scan_enabled_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "example"
        ],
        "Attributes": {
            "sku": "Premium"
        },
        "Blocks": [
            {
                "Type": "trust_policy",
                "Labels": [],
                "Attributes": {
                    "enabled": true
                },
                "Blocks": [
                    {
                        "Type": "signer",
                        "Labels": [],
                        "Attributes": {
                            "issuer": "my-issuer",
                            "subject": "my-subject"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 9,
                            "startLine": 6
                        }
                    }
                ],
                "line_range": {
                    "endLine": 10,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_acr_container_scan_enabled_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_container_registry",
            "example"
        ],
        "Attributes": {
            "sku": "Basic"
        },
        "Blocks": [
            {
                "Type": "trust_policy",
                "Labels": [],
                "Attributes": {
                    "enabled": true
                },
                "Blocks": [
                    {
                        "Type": "signer",
                        "Labels": [],
                        "Attributes": {
                            "issuer": "my-issuer",
                            "subject": "my-subject"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 9,
                            "startLine": 6
                        }
                    }
                ],
                "line_range": {
                    "endLine": 10,
                    "startLine": 3
                }
            }
        ],
        "line_range": {
            "endLine": 13,
            "startLine": 1
        }
    }
]
	count(result) == 1
}