package lib.azurearm.CB_AZR_064

test_azr_key_vault_enables_soft_delete_pass{
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults",
                "apiVersion": "2019-09-01",
                "properties": {
                    "enableSoftDelete": true
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_key_vault_enables_soft_delete_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults",
                "apiVersion": "2019-09-01",
                "properties": {
                    "enableSoftDelete": false
                }
            }
        ]
    }
	count(result) == 1
}