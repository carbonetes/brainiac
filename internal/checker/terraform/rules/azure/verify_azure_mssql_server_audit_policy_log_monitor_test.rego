package lib.terraform.CB_TFAZR_170

test_azure_mssql_server_audit_policy_log_monitor_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_mssql_database_extended_auditing_policy",
            "pass2"
        ],
        "Attributes": {
            "log_monitoring_enabled": true
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azure_mssql_server_audit_policy_log_monitor_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_mssql_database_extended_auditing_policy",
            "pass2"
        ],
        "Attributes": {
            "log_monitoring_enabled": false
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    }]
	count(result) == 1
}