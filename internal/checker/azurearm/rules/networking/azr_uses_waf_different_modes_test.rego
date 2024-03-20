package lib.azurearm.CB_AZR_069

test_azr_uses_waf_various_modes_pass{
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/FrontDoorWebApplicationFirewallPolicies",
                "apiVersion": "2020-11-01",
                "properties": {
                    "policySettings": {
                        "enabledState": "Enabled",
                        "mode": "Prevention" 
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_uses_waf_various_modes_fail{
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/FrontDoorWebApplicationFirewallPolicies",
                "apiVersion": "2020-11-01",
                "properties": {
                    "policySettings": {
                        "enabledState": "Disabled",
                        "mode": "Prevention" 
                    }
                }
            }
        ]
    }
	count(result) == 1
}