package lib.azurearm.CB_AZR_009

test_rdp_access_restricted_internet_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.Network/networkSecurityGroups",
            "properties": {
                "securityRules": [
                {
                    "properties": {
                        "destinationPortRange": "3389",
                    }
                }
                ]
            }
        }]
	}
	count(result) == 1
}

test_rdp_access_restricted_internet_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.Network/networkSecurityGroups",
            "properties": {
                "securityRules": [
                {
                    "properties": {
                        "destinationPortRange": "3399",
                    }
                }
                ]
            }
        }]
	}

	count(result) == 1
}
