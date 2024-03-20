package lib.azurearm.CB_AZR_039

test_azr_register_active_directory_enabled {
	result := passed with input as {
    "resources": [
       {
            "type": "Microsoft.Authorization/roleDefinitions",
            "name": "subscription owner role definition",
            "properties": {
                "roleName": "Subscription Owner"
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
                "type": "Microsoft.Authorization/roleDefinitions",
                "name": "subscription owner role definition",
                "properties": {
                    "roleName": "Subscription Owner",
                    "permissions": [
                        {
                            "actions": ["*"]
                        }
                    ],
                    "assignableScopes": [
                        "/subscriptions/12345678-1234-5678-abcd-1234567890ab"
                    ]
                }
            }
        ]
}
	count(result) == 1
}
