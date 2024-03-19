package lib.azurearm.CB_AZR_018

test_azr_web_app_http_version_latest_enabled{
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "http20Enabled": true
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_web_app_http_version_latest_not_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "http20Enabled": false
                }
            }
        ]
    }
	count(result) == 1
}