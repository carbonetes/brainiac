package lib.terraform.CB_TFAZR_172

test_azurerm_frontdoor_firewall_policy_message_lookup_disabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_frontdoor_firewall_policy",
			"example",
		],
		"Attributes": {
			"name": "example",
			"resource_group_name": "example",
		},
		"Blocks": [{
			"Type": "managed_rule",
			"Labels": [],
			"Attributes": {
				"type": "Microsoft_DefaultRuleSet",
				"version": "1.1",
			},
			"Blocks": [{
				"Type": "override",
				"Labels": [],
				"Attributes": {"rule_group_name": "JAVA"},
				"Blocks": [{
					"Type": "rule",
					"Labels": [],
					"Attributes": {
						"action": "Block",
						"enabled": true,
						"rule_id": "944240",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 16,
						"startLine": 12,
					},
				}],
				"line_range": {
					"endLine": 17,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 18,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 19,
			"startLine": 1,
		},
	}]

	count(result) == 1
}

test_azurerm_frontdoor_firewall_policy_message_lookup_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_frontdoor_firewall_policy",
			"example",
		],
		"Attributes": {
			"name": "example",
			"resource_group_name": "example",
		},
		"Blocks": [{
			"Type": "not_managed_rule",
			"Labels": [],
			"Attributes": {
				"type": "Microsoft_DefaultRuleSet",
				"version": "1.1",
			},
			"Blocks": [{
				"Type": "not_override",
				"Labels": [],
				"Attributes": {"rule_group_name": "JAVA"},
				"Blocks": [{
					"Type": "rule",
					"Labels": [],
					"Attributes": {
						"action": "",
						"enabled": false,
						"rule_id": "",
					},
					"Blocks": [],
					"line_range": {
						"endLine": 16,
						"startLine": 12,
					},
				}],
				"line_range": {
					"endLine": 17,
					"startLine": 9,
				},
			}],
			"line_range": {
				"endLine": 18,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 19,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
