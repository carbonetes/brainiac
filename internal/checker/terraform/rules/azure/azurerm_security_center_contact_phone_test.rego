package lib.terraform.CB_TFAZR_087

test_azurerm_security_center_contact_phone_passed {
	result := passed with input as [ 
        {
            "Type": "resource",
            "Labels": [
                "azurerm_security_center_contact",
                "example"
            ],
            "Attributes": {
                "alert_notifications": true,
                "alerts_to_admins": true,
                "email": "contact@example.com",
                "name": "contact",
                "phone": "+1-555-555-5555"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}

test_azurerm_security_center_contact_phone_failed {
	result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "azurerm_security_center_contact",
                "example"
            ],
            "Attributes": {
                "alert_notifications": true,
                "alerts_to_admins": true,
                "email": "contact@example.com",
                "name": "contact"
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}