package lib.azurearm.CB_AZR_070

test_azr_postgres_server_enable_encryption_pass{
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.DBforPostgreSQL/servers",
                "apiVersion": "2020-11-05-preview",
                "properties": {
                    "infrastructureEncryption": "Enabled"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_postgres_server_enable_encryption_fail{
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DBforPostgreSQL/servers",
                "apiVersion": "2020-11-05-preview",
                "properties": {
                    "infrastructureEncryption": "Disabled"
                }
            }
        ]
    }
	count(result) == 1
}