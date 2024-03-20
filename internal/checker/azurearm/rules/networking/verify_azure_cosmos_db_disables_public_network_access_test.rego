package lib.azurearm.CB_AZR_060

test_azure_cosmos_db_public_access_disabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                    "publicNetworkAccess": "Disabled"
                }
            }
            ]
        }
	count(result) == 1
}

test_azure_cosmos_db_public_access_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DocumentDB/databaseAccounts",
                "properties": {
                    "publicNetworkAccess": "Enabled"
                }
            }
            ]
        }
	count(result) == 1
}
