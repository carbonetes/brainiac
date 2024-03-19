package lib.azurearm.CB_AZR_017

test_azr_web_app_client_cert_enabled {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites",
            "name": "exampleWebApp",
            "properties": {
                "clientCertEnabled": "true"
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_web_app_client_cert_not_enabled {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Web/sites",
            "name": "exampleWebApp",
            "properties": {
                "clientCertEnabled": "false"
            }
            }
        ]
    }
	count(result) == 1
}
