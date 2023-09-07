package lib.terraform.CB_TFAZR_004

test_azurerm_security_center_contact_notif_admins_enabled {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"alerts_to_admins": true},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_security_center_contact_notif_admins_not_enabled {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"alerts_to_admins": false},
		"Blocks": [],
		"line_range": {
			"endLine": 3,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
