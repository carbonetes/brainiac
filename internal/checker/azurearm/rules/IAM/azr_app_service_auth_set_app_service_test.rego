package lib.azurearm.CB_AZR_013

test_azr_intance_does_not_allow_basic_auth {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.Web/sites/config",
            "name": "authsettings",
            "properties": {
                "enabled": true
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
            "type": "Microsoft.Web/sites/config",
            "name": "authsettings",
            "properties": {
                "enabled": false
            }
        }
    ]
}
	count(result) == 1
}
