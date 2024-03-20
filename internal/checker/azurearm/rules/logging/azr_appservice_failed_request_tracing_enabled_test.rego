package lib.azurearm.CB_AZR_050

test_azr_appservice_failed_request_tracing_enabled_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2021-02-01",
            "properties": {
                "requestTracingEnabled": true
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_appservice_failed_request_tracing_enabled_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites/config",
            "apiVersion": "2021-02-01",
            "properties": {
                "requestTracingEnabled": false
            }
            }
        ]
    }
	count(result) == 1
}
