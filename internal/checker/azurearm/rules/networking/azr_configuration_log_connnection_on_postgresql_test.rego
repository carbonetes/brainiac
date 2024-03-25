package lib.azurearm.CB_AZR_031

test_azr_configuration_log_connection_on_postgresql_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.DBforPostgreSQL/servers/configurations",
                "apiVersion": "2021-05-01",
                "name": "log_connections",
                "properties": {
                    "value": "on"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_configuration_log_connection_on_postgresql_not_enabled  {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DBforPostgreSQL/servers/configurations",
                "apiVersion": "2021-05-01",
                "name": "log_connections",
                "properties": {
                    "value": "off"
                }
            }
        ]
    }
	count(result) == 1
}