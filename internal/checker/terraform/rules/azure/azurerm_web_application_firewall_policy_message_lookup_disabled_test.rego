package lib.terraform.CB_TFAZR_179

test_azurerm_web_application_firewall_policy_message_lookup_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_web_application_firewall_policy",
			"example",
		],
		"Attributes": {
			"location": "germanywestcentral",
			"name": "example",
			"resource_group_name": "example",
		},
		"Blocks": [
			{
				"Type": "managed_rules",
				"Labels": [],
				"Attributes": {},
				"Blocks": [
					{
						"Type": "managed_rule_set",
						"Labels": [],
						"Attributes": {
							"type": "OWASP",
							"version": "3.1",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 10,
							"startLine": 7,
						},
					},
					{
						"Type": "rule_group_override",
						"Labels": [],
						"Attributes": {
							"disabled_rules": ["944240"],
							"rule_group_name": "REQUEST-944-APPLICATION-ATTACK-JAVA",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 16,
							"startLine": 12,
						},
					},
				],
				"line_range": {
					"endLine": 17,
					"startLine": 6,
				},
			},
			{
				"Type": "policy_settings",
				"Labels": [],
				"Attributes": {},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 19,
				},
			},
		],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_web_application_firewall_policy_message_lookup_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_web_application_firewall_policy",
			"example",
		],
		"Attributes": {
			"location": "germanywestcentral",
			"name": "example",
			"resource_group_name": "example",
		},
		"Blocks": [
			{
				"Type": "managed_rules",
				"Labels": [],
				"Attributes": {},
				"Blocks": [
					{
						"Type": "managed_rule_set",
						"Labels": [],
						"Attributes": {
							"type": "",
							"version": "3.0",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 10,
							"startLine": 7,
						},
					},
					{
						"Type": "rule_group_override",
						"Labels": [],
						"Attributes": {
							"disabled_rules": [""],
							"rule_group_name": "",
						},
						"Blocks": [],
						"line_range": {
							"endLine": 16,
							"startLine": 12,
						},
					},
				],
				"line_range": {
					"endLine": 17,
					"startLine": 6,
				},
			},
			{
				"Type": "policy_settings",
				"Labels": [],
				"Attributes": {},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 19,
				},
			},
		],
		"line_range": {
			"endLine": 20,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
