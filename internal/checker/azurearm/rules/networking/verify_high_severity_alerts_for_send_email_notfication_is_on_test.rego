package lib.azurearm.CB_AZR_021

test_high_severity_alerts_send_email_on {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Security/securityContacts",
		"properties": {"alertNotifications": "On"},
	}]}
    count(result) == 1
}

test_high_severity_alerts_send_email_off {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Security/securityContacts",
		"properties": {"alertNotifications": "Off"},
	}]}
    count(result) == 1
}
