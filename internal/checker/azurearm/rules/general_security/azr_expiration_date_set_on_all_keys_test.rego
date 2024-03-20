package lib.azurearm.CB_AZR_040

test_azr_intance_does_not_allow_basic_auth {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/keys",
                "properties": {
                    "rotationPolicy": {
                        "attributes": {
                            "expiryTime": "2025-12-31T23:59:59Z"
                        }
                    }
                }
            }
        ]
}
	count(result) == 1
}

test_azr_intance_does_allow_basic_auth {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.KeyVault/vaults/keys",
                "properties": {
                    "rotationPolicy": {
                        "attributes": {
                            "expiryTime": ""
                        }
                    }
                }
            }
        ]
    }
	count(result) == 1
}
