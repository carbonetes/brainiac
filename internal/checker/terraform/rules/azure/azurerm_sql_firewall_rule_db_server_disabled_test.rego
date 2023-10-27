package lib.terraform.CB_TFAZR_241

test_azurerm_sql_firewall_rule_db_server_disabled {
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
   "azurerm_sql_server",
   "sql_server_good"
  ],
  "Attributes": {
   "administrator_login": "4dm1n157r470r",
   "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
   "location": "West US",
   "name": "mysqlserver",
   "resource_group_name": "azurerm_resource_group.example.name",
   "version": "12.0"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 13,
   "startLine": 6
  }
 },
 {
  "Type": "resource",
  "Labels": [
   "azurerm_sql_firewall_rule",
   "firewall_rule_good"
  ],
  "Attributes": {
   "end_ip_address": "10.0.17.62",
   "name": "FirewallRule1",
   "resource_group_name": "azurerm_resource_group.example.name",
   "server_name": "azurerm_sql_server.sql_server_good.name",
   "start_ip_address": "10.0.17.62"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 21,
   "startLine": 15
  }
 },
	]
	count(result) == 1
}

test_azurerm_sql_firewall_rule_db_server_enabled {
	result := failed with input as [
		
 {
  "Type": "resource",
  "Labels": [
   "azurerm_sql_server",
   "sql_server_good"
  ],
  "Attributes": {
   "administrator_login": "4dm1n157r470r",
   "administrator_login_password": "4-v3ry-53cr37-p455w0rd",
   "location": "West US",
   "name": "mysqlserver",
   "resource_group_name": "azurerm_resource_group.example.name",
   "version": "12.0"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 13,
   "startLine": 6
  }
 },
 {
  "Type": "resource",
  "Labels": [
   "azurerm_sql_firewall_rule",
   "firewall_rule_good"
  ],
  "Attributes": {
   "end_ip_address": "0.0.0.0",
   "name": "FirewallRule1",
   "resource_group_name": "azurerm_resource_group.example.name",
   "server_name": "azurerm_sql_server.sql_server_good.name",
   "start_ip_address": "0.0.0.0"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 21,
   "startLine": 15
  }
 },
	]
	count(result) == 1
}
