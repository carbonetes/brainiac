package lib.azurearm.CB_AZR_015

test_azr_intance_does_not_allow_basic_auth {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "siteConfig": {
                        "minTlsVersion": "1.2"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_intance_does_allow_basic_auth {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Web/sites",
                "name": "exampleWebApp",
                "properties": {
                    "siteConfig": {
                        "minTlsVersion": "1.0"
                    }
                }
            }
        ]
    }
	count(result) == 1
}
