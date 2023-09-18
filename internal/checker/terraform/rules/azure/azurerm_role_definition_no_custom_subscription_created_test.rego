package lib.terraform.CB_TFAZR_029

test_azurerm_role_definition_no_custom_subscription_created {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_role_definition",
			"example",
		],
		"Attributes": {
			"description": "This is a custom role created via Terraform",
			"name": "my-custom-role",
			"scope": "data.azurerm_subscription.primary.id",
		},
		"Blocks": [{
			"Type": "permissions",
			"Labels": [],
			"Attributes": {"actions": []},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_role_definition_no_custom_subscription_not_created {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_role_definition",
			"example",
		],
		"Attributes": {
			"description": "This is a custom role created via Terraform",
			"name": "my-custom-role",
			"scope": "data.azurerm_subscription.primary.id",
		},
		"Blocks": [{
			"Type": "permissions",
			"Labels": [],
			"Attributes": {"actions": ["*"]},
			"Blocks": [],
			"line_range": {
				"endLine": 10,
				"startLine": 5,
			},
		}],
		"line_range": {
			"endLine": 15,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
