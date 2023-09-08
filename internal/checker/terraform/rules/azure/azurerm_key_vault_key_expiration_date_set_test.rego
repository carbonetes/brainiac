package lib.terraform.CB_TFAZR_010

test_azurerm_key_vault_key_expiration_date_set {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_key_vault_key",
			"generated",
		],
		"Attributes": {"expiration_date": "2020-12-30T20:00:00Z"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_key_vault_key_expiration_date_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_key_vault_key",
			"generated",
		],
		"Attributes": {"expiration_date": ""},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
