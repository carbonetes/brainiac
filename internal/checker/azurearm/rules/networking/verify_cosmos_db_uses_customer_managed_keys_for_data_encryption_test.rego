package lib.azurearm.CB_AZR_059

test_cosmos_db_customer_managed_keys_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                    "keyVaultKeyUri": "your_keyvault_key_uri_here"
                }
            }
        ]
    }
	count(result) == 1
}

test_cosmos_db_customer_managed_keys_disabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                    "keyVaultKeyUri": ""
                }
            }
        ]
    }
	count(result) == 1
}
