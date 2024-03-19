package lib.azurearm.CB_AZR_028

test_mysql_database_ssl_connection_enabled {
	result := passed with input as {
    "resources": [
        {
            "type": "Microsoft.DBforMySQL/servers",
            "properties": {
                "sslEnforcement": "Enabled"
            }
        }
    ]
}
	count(result) == 1
}

test_mysql_database_ssl_connection_disabled {
	result := failed with input as {
    "resources": [
        {
            "type": "Microsoft.DBforMySQL/servers",
            "properties": {
                "sslEnforcement": "Disabled"
            }
        }
    ]
}
	count(result) == 1
}
