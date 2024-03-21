package lib.azurearm.CB_AZR_073

test_azr_cognitive_services_public_network_access_disabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.CognitiveServices/accounts",
                "properties": {
                    "publicNetworkAccess": "Disabled"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_cognitive_services_public_network_access_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.CognitiveServices/accounts",
                "properties": {
                    "publicNetworkAccess": "Enabled"
                }
            }
        ]
    }
	count(result) == 1
}
