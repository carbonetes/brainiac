package lib.azurearm.CB_AZR_049

test_azr_appservice_error_messages_enabled_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2022-09-01",
            "properties": {
                "detailedErrorLoggingEnabled": true
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_appservice_error_messages_enabled_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2022-09-01",
            "properties": {
                "detailedErrorLoggingEnabled": false
            }
            }
        ]
    }
	count(result) == 1
}
