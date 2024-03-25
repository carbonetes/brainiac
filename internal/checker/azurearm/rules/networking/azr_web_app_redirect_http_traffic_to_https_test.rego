package lib.azurearm.CB_AZR_014

test_azr_web_app_redirects_http_traffic_to_https {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.Web/sites",
            "name": "exampleWebApp",
            "properties": {
                "httpsOnly": true
            }
        }
    ]
}
	count(result) == 1
}

test_azr_web_app_does_not_redirect_http_traffic_to_https {
	result := failed with input as {
    "resources": [
        {
            "type": "Microsoft.Web/sites",
            "name": "exampleWebApp",
            "properties": {
                "httpsOnly": false
            }
        }
    ]
}
	count(result) == 1
}
