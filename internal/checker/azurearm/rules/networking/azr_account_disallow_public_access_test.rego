package lib.azurearm.CB_AZR_047

test_azr_account_disallow_public_access_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2023-01-01",
            "properties": {
                "publicNetworkAccess": "Disabled"
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_account_disallow_public_access_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2023-01-01",
            "properties": {
                "publicNetworkAccess": "Enabled"
            }
            }
        ]
    }
	count(result) == 1
}