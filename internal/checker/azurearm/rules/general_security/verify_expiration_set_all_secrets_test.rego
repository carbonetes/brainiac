package lib.azurearm.CB_AZR_041

test_expiration_set_all_secrets_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.KeyVault/vaults/secrets",
            "apiVersion": "2022-07-01",
            "properties": {
                "attributes": {
                "exp": 1742384000, 
                },
            }
        }]
	}
	count(result) == 1
}

test_expiration_set_all_secrets_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.KeyVault/vaults/secrets",
            "apiVersion": "2022-07-01",
            "properties": {
                "attributes": {},
            }
        }]
	}

	count(result) == 1
}
