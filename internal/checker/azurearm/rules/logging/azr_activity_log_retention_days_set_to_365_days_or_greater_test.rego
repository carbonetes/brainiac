package lib.azurearm.CB_AZR_037

test_azr_activity_log_retention_days_is_set_to_365_days_or_greater {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.Insights/logprofiles",
            "name": "*",
            "properties": {
                "retentionPolicy": {
                    "enabled": "true",
                    "days": 365
                }
            }
        }
    ]
}
	count(result) == 1
}

test_azr_activity_log_retention_days_is_not_set_to_365_days_or_greater {
	result := failed with input as {
    "resources": [
        {
            "type": "Microsoft.Insights/logprofiles",
            "name": "*",
            "properties": {
                "retentionPolicy": {
                    "enabled": "false",
                    "days": 364
                }
            }
        }
    ]
}
	count(result) == 1
}
