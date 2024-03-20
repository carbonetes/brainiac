package lib.azurearm.CB_AZR_035

test_azr_default_network_access_deny_storage_account_set_to_deny {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts",
                "name": "*",
                "apiVersion": "2022-02-20",
                "properties": {
                    "networkAcls": {
                        "defaultAction": "Deny"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_default_network_access_deny_storage_account_not_set_to_deny {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Storage/storageAccounts",
                "name": "*",
                "apiVersion": "2017-02-20",
                "properties": {
                    "networkAcls": {
                        "defaultAction": "Accept"
                    }
                }
            }
        ]
    }
	count(result) == 1
}