package lib.azurearm.CB_AZR_066

test_azr_sql_server_disabled_public_network_pass {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Sql/servers",
                "apiVersion": "2020-11-01-preview",
                "properties": {     
                    "publicNetworkAccess": "Disabled"
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_sql_server_disabled_public_network_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Sql/servers",
                "apiVersion": "2020-11-01-preview",
                "properties": {     
                    "publicNetworkAccess": "Enabled"
                }
            }
        ]
    }
	count(result) == 1
}