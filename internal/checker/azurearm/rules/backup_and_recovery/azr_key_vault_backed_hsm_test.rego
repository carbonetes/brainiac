package lib.azurearm.CB_AZR_065

test_azr_key_vault_backed_hsm_pass{
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/keys",
                "apiVersion": "2019-09-01",
                "properties": {
                    "kty": "RSA-HSM"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_key_vault_backed_hsm_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/keys",
                "apiVersion": "2019-09-01",
                "properties": {
                    "kty": "RSA"
                }
            }
        ]
    }
	count(result) == 1
}