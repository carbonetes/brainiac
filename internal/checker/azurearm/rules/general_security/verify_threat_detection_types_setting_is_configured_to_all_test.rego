package lib.azurearm.CB_AZR_025

test_threat_detection_configured_all {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
			"state": "Enabled",
			"disabledAlerts": [],
		},
	}]}
	count(result) == 1
}

test_threat_detection_configured_not_all {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers/databases",
		"properties": {
			"state": "Disabled",
			"disabledAlerts": ["Sample"],
		},
	}]}
	count(result) == 1
}
