package lib.azurearm.CB_AZR_068

test_azr_frontdoor_waf_enabled_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Network/frontDoors",
            "apiVersion": "2021-06-01",
            "properties": {
                "frontendEndpoints": [
                {
                    "id": "exampleFrontendEndpoint",
                    "name": "exampleFrontendEndpoint",
                    "properties": {
                        "sessionAffinityEnabledState": "Enabled",
                        "webApplicationFirewallPolicyLink": {
                            "id": "exampleWAFPolicy"
                        }
                    }
                }
                ]
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_frontdoor_waf_enabled_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Network/frontDoors",
            "apiVersion": "2021-06-01",
            "properties": {
                "frontendEndpoints": [
                {
                    "id": "exampleFrontendEndpoint",
                    "name": "exampleFrontendEndpoint",
                    "properties": {
                        "sessionAffinityEnabledState": "Enabled"
                    }
                }
                ]
            }
            }
        ]
    }
	count(result) == 1
}