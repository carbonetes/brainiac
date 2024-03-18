package lib.azurearm.CB_AZR_012

test_azr_network_security_group_retention_greater_than_90 {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/networkWatchers/FlowLogs",
                "properties": {
                    "retentionPolicy": {
                        "enabled": true,
                        "days": 120
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_network_security_group_retention_not_greater_than_90 {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Network/networkWatchers/FlowLogs",
                "properties": {
                    "retentionPolicy": {
                        "enabled": false,
                        "days": 80
                    }
                }
            }
        ]
    }
	count(result) == 1
}
