package lib.azurearm.CB_AZR_024

test_auditing_retention_exceeds_90 {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {
			"state": "Enabled",
			"retentionDays": 91
		},
	}]}
    count(result) == 1
}

test_auditing_retention_below_90 {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {
			"state": "Disabled",
			"retentionDays": 89
		},
	}]}
    count(result) == 1
}
