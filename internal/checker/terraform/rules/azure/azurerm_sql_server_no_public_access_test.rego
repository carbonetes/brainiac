package lib.terraform.CB_TFAZR_031

test_azurem_sql_server_no_public_access_passed {
    result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_mariadb_firewall_rule",
            "pass_firewall"
        ],
        "Attributes": {
            "end_ip_address": "40.112.255.255",
            "name": "test-rule",
            "resource_group_name": "test-rg",
            "server_name": "test-server",
            "start_ip_address": "40.112.0.0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}

test_azurem_sql_server_no_public_access_failed {
    result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "azurerm_mariadb_firewall_rule",
            "pass_firewall"
        ],
        "Attributes": {
            "end_ip_address": "255.255.255.255",
            "name": "test-rule",
            "resource_group_name": "test-rg",
            "server_name": "test-server",
            "start_ip_address": "0.0.0.0"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 7,
            "startLine": 1
        }
    }]
	count(result) == 1
}