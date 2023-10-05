package lib.terraform.CB_TFAZR_132

test_azure_postgre_sql_min_tls_version_passed {
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
            "azurerm_postgresql_server",
            "pass"
        ],
        "Attributes": {
            "name": "fail",
            "public_network_access_enabled": true,
            "ssl_enforcement_enabled": true,
            "ssl_minimal_tls_version_enforced": "TLS1_2"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_postgre_sql_min_tls_version_failed {
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
            "azurerm_postgresql_server",
            "pass"
        ],
        "Attributes": {
            "name": "fail",
            "public_network_access_enabled": true,
            "ssl_enforcement_enabled": true,
            "ssl_minimal_tls_version_enforced": "TLS1_0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 11,
            "startLine": 5
        }
    }]
	count(result) == 1
}