package lib.terraform.CB_TFAZR_218

test_azure_mssql_server_has_security_alert_policy_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_sql_server",
            "sql_server_good_1"
        ],
        "Attributes": {
            "administrator_login": "4dm1n157r470r",
            "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
            "location": "location",
            "name": "mysqlserver",
            "resource_group_name": "group",
            "version": "12.0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_mssql_server_security_alert_policy",
            "alert_policy_good"
        ],
        "Attributes": {
            "resource_group_name": "group",
            "retention_days": "20",
            "server_name": "azurerm_sql_server.sql_server_good_1.name",
            "state": "Enabled"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 25,
            "startLine": 20
        }
    }]
	count(result) == 1
}

test_azure_mssql_server_has_security_alert_policy_failed {
	result := failed with input as [{
        "Attributes": {
            "administrator_login": "4dm1n157r470r",
            "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
            "location": "location",
            "name": "mysqlserver",
            "resource_group_name": "group",
            "version": "12.0"
        },
        "Blocks": [],
        "Labels": [
            "azurerm_sql_server",
            "sql_server_good_1"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 8,
            "startLine": 1
        }
    },
    {
        "Attributes": {
            "resource_group_name": "group",
            "retention_days": "20",
            "server_name": "",
            "state": ""
        },
        "Blocks": [],
        "Labels": [
            "azurerm_mssql_server_security_alert_policy",
            "alert_policy_good"
        ],
        "Type": "resource",
        "line_range": {
            "endLine": 25,
            "startLine": 20
        }
    }]
	count(result) == 1
}