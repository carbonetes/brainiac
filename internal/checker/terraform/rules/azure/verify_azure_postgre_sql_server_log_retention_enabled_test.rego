package lib.terraform.CB_TFAZR_116

test_azure_postgre_sql_server_log_retention_enabled_passed {
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
            "azurerm_postgresql_configuration",
            "log_retention"
        ],
        "Attributes": {
            "name": "log_retention",
            "value": "on"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}

test_azure_postgre_sql_server_log_retention_enabled_failed {
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
            "azurerm_postgresql_configuration",
            "log_retention"
        ],
        "Attributes": {
            "name": "notlog_retention",
            "value": "off"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 5
        }
    }]
	count(result) == 1
}