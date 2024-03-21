package lib.azurearm.CB_AZR_076

test_internet_access_restricted {
	result := passed with input as {"resources": [
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "properties": {
                "securityRules": [
                    {
                        "access": "Deny",
                        "destinationPortRange": "*"
                    }
                ]
            }
        }
        ]
    }
    count(result) == 1
}

test_internet_access_not_restricted {
	result := failed with input as {"resources": [
        {
            "type": "Microsoft.Network/networkSecurityGroups",
            "properties": {
                "securityRules": [
                    {
                        "access": "Allow",
                        "destinationPortRange": "80"
                    }
                ]
            }
        }
        ]
    }
    count(result) == 1
}
