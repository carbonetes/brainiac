package lib.azurearm.CB_AZR_042

test_key_vault_recoverable_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.KeyVault/vaults",
            "apiVersion": "2019-09-01",
                "properties": {
                    "enablePurgeProtection": "true",
                    "enableSoftDelete": "true"
                }
            }
        ]
	}
	count(result) == 1
}

test_key_vault_recoverable_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.KeyVault/vaults",
            "apiVersion": "2019-09-01",
                "properties": {
                    "enablePurgeProtection": "false",
                    "enableSoftDelete": "false"
                }
            }
        ]
	}

	count(result) == 1
}
