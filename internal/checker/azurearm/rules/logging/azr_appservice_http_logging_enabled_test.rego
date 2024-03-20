package lib.azurearm.CB_AZR_048

test_azr_appservice_http_logging_enabled_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2022-09-01",
            "properties": {
                "httpLoggingEnabled": true
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_appservice_http_logging_enabled_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2022-09-01",
            "properties": {
                "httpLoggingEnabled": false
            }
            }
        ]
    }
	count(result) == 1
}
