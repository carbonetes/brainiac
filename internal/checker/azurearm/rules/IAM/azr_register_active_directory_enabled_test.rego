package lib.azurearm.CB_AZR_016

test_azr_register_active_directory_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "identity": {
                        "type": "UserAssigned",
                        "userAssignedIdentities": {
                            "exampleIdentity1": {
                                "clientId": "12345678-1234-1234-1234-123456789abc"
                            },
                            "exampleIdentity2": {
                                "clientId": "98765432-9876-9876-9876-987654321cba"
                            }
                        }
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_register_active_directory_not_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "identity": {
                        "type": "UserAssigned",
                        "userAssignedIdentities": {
                            
                        }
                    }
                }
            }
        ]
    }
	count(result) == 1
}
