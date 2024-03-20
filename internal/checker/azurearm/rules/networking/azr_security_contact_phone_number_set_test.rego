package lib.azurearm.CB_AZR_020

test_azr_security_contact_phone_number_is_set {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Security/securityContacts",
                "name": "exampleSecurityContact",
                "properties": {
                    "phone": "123-456-7890"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_security_contact_phone_number_not_set {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Security/securityContacts",
                "name": "exampleSecurityContact",
                "properties": {
                }
            }
        ]
    }
	count(result) == 1
}