package lib.terraform.CB_TFAZR_128

test_azurerm_security_center_contact_emails_set {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"email": "contact@example.com"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_azurerm_security_center_contact_emails_not_set {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"azurerm_security_center_contact",
			"example",
		],
		"Attributes": {"not_email": "contact@example.com"},
		"Blocks": [],
		"line_range": {
			"endLine": 4,
			"startLine": 1,
		},
	}]
	count(result) == 1
}
