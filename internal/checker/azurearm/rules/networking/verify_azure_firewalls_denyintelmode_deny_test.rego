package lib.azurearm.CB_AZR_077

test_azure_firewalls_denyintelmode_deny {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/azureFirewalls",
                "properties": {
                    "threatIntelMode": "Deny"
                }
            }
        ]
    }
	count(result) == 1
}

test_azure_firewalls_denyintelmode_not_deny {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/azureFirewalls",
                "properties": {
                    "threatIntelMode": "Alert"
                }
            }
        ]
    }
	count(result) == 1
}
