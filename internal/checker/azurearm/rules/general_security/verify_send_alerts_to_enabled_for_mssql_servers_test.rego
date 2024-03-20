package lib.azurearm.CB_AZR_026

test_send_alerts_to_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
			"state": "Enabled",
			"emailAddresses": "juan@carbonetes.com",
		},
	}]}
	count(result) == 1
}

test_send_alerts_to_not_enabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
			"state": "Disabled",
			"emailAddresses": "",
		},
	}]}
	count(result) == 1
}
