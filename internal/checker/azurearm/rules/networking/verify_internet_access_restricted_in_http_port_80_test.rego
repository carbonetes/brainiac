package lib.azurearm.CB_AZR_076

test_high_severity_alerts_send_email_on {
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

test_high_severity_alerts_send_email_off {
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
