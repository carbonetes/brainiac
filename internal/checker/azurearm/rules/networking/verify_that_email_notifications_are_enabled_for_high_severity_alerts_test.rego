package lib.azurearm.CB_AZR_022

test_alerts_to_admin_email_notifications_on {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Security/securityContacts",
		"properties": {"alertsToAdmins": "On"},
	}]}
    count(result) == 1
}

test_alerts_to_admin_email_notifications_off {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Security/securityContacts",
		"properties": {"alertsToAdmins": "Off"},
	}]}
    count(result) == 1
}
