package lib.azurearm.CB_AZR_063

test_azr_key_vault_allow_firewall_settings_pass {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults",
                "apiVersion": "2019-09-01",
                "properties": {
                    "networkAcls": {
                        "defaultAction": "Allow"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_key_vault_allow_firewall_settings_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults",
                "apiVersion": "2019-09-01",
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