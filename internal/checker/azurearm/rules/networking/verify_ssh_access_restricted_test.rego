package lib.azurearm.CB_AZR_010

test_ssh_access_restricted_internet_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "properties": {
                "securityRules": [
                {
                    "properties": {
                        "destinationPortRange": "22",
                    }
                }
                ]
            }
        }]
	}
	count(result) == 1
}

test_ssh_access_restricted_internet_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.Network/networkSecurityGroups/securityRules",
            "properties": {
                "securityRules": [
                {
                    "properties": {
                        "destinationPortRange": "32",
                    }
                }
                ]
            }
        }]
	}

	count(result) == 1
}
