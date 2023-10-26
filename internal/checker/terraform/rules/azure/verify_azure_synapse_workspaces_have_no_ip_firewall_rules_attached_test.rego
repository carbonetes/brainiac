package lib.terraform.CB_TFAZR_236

test_azure_synapse_workspaces_have_no_ip_firewall_rules_attached_passed {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "example-resources"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_workspace",
            "workspace_good"
        ],
        "Attributes": {
            "managed_virtual_network_enabled": true,
            "name": "example",
            "sql_administrator_login": "sqladminuser",
            "sql_administrator_login_password": "H@Sh1CoR3!",
            "tags": {
                "Env": "production"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_firewall_rule",
            "firewall_rule"
        ],
        "Attributes": {
            "end_ip_address": "255.255.255.255",
            "name": "AllowAll",
            "start_ip_address": "0.0.0.0",
            "synapse_workspace_id": ""
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 17
        }
    }
]
	count(result) == 1
}

test_azure_synapse_workspaces_have_no_ip_firewall_rules_attached_failed {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "azurerm_resource_group",
            "example"
        ],
        "Attributes": {
            "location": "West Europe",
            "name": "example-resources"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 4,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_workspace",
            "workspace_good"
        ],
        "Attributes": {
            "managed_virtual_network_enabled": true,
            "name": "example",
            "sql_administrator_login": "sqladminuser",
            "sql_administrator_login_password": "H@Sh1CoR3!",
            "tags": {
                "Env": "production"
            }
        },
        "Blocks": [],
        "line_range": {
            "endLine": 14,
            "startLine": 6
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "azurerm_synapse_firewall_rule",
            "firewall_rule"
        ],
        "Attributes": {
            "end_ip_address": "255.255.255.255",
            "name": "AllowAll",
            "start_ip_address": "0.0.0.0",
            "synapse_workspace_id": "azurerm_synapse_workspace.workspace_good.id"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 22,
            "startLine": 17
        }
    }
]
	count(result) == 1
}