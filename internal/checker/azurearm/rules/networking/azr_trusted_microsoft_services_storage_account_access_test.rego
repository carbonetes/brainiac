package lib.azurearm.CB_AZR_036

test_azr_trusted_microsoft_services_storage_account_access_enabled {
	result := passed with input as {
        "resources": [
            {
                "apiVersion": "2022-02-20",
                "type": "Microsoft.Storage/storageAccounts",
                "name": "*",
                "properties": {
                    "networkAcls": {
                        "defaultAction": "Allow",
                        "bypass": "AzureServices"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_trusted_microsoft_services_storage_account_access_not_enabled {
	result := failed with input as {
        "resources": [
            {
                "apiVersion": "2022-02-20",
                "type": "Microsoft.Storage/storageAccounts",
                "name": "*",
                "properties": {
                    "networkAcls": {
                        "defaultAction": "Deny",
                        "bypass": "None"
                    }
                }
            }
        ]
    }
	count(result) == 1
}