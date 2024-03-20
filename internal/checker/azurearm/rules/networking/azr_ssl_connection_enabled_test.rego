package lib.azurearm.CB_AZR_043

test_azr_ssl_connection_enabled_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.DBforMariaDB/servers",
            "apiVersion": "2020-01-01-preview",
            "properties": {
                "version": "10.4",
                "sslEnforcement": "Enabled"
            }
            }
        ]
    }
	count(result) == 1
}

test_azr_ssl_connection_enabled_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.DBforMariaDB/servers",
            "apiVersion": "2020-01-01-preview",
            "properties": {
                "version": "10.4",
                "sslEnforcement": "Disabled"
            }
            }
        ]
    }
	count(result) == 1
}