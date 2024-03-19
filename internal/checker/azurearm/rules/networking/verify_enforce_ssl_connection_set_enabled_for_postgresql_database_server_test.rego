package lib.azurearm.CB_AZR_029

test_postgresql_ssl_connection_enabled {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.DBforPostgreSQL/servers/configurations",
            "properties": {
                "sslEnforcement": "Enabled"
            }
        }
    ]
}
	count(result) == 1
}

test_postgresql_ssl_connection_disabled {
	result := failed with input as {
    "resources": [
        {
            "type": "Microsoft.DBforPostgreSQL/servers/configurations",
            "properties": {
                "sslEnforcement": "Disabled"
            }
        }
    ]
}
	count(result) == 1
}