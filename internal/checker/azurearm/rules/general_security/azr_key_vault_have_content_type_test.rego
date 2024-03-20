package lib.azurearm.CB_AZR_067

test_azr_key_vault_have_content_type_pass {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/secrets",
                "apiVersion": "2019-09-01",        
                "properties": {
                    "contentType": "[parameters('contentType')]",
                    "value": "[parameters('secretValue')]"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_key_vault_have_content_type_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/secrets",
                "apiVersion": "2019-09-01",        
                "properties": {
                    "value": "[parameters('secretValue')]"
                }
            }
        ]
    }
	count(result) == 1
}