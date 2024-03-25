package lib.azurearm.CB_AZR_011

test_azr_sql_database_does_not_allow_ingress {
	result := passed with input as {
    "resources": [
        {
            "type": "firewallrules",
            "apiVersion": "2019-06-01-preview",
            "name": "allowAllIngress",
            "properties": {
                "startIpAddress": "0.0.0.0",
                "endIpAddress": "0.0.0.0",
                "firewallRuleName": "allowAllIngress",
                "serverName": "exampleSqlServer",
                "resourceGroupName": "exampleResourceGroup"
            }
        }
    ]
}
	count(result) == 1
}

test_azr_sql_database_does_allow_ingress {
	result := failed with input as {
    "resources": [
        {
            "type": "firewallrules",
            "apiVersion": "2019-06-01-preview",
            "name": "allowAllIngress",
            "properties": {
                "startIpAddress": "0.0.0.0",
                "endIpAddress": "255.255.255.255",
                "firewallRuleName": "allowAllIngress",
                "serverName": "exampleSqlServer",
                "resourceGroupName": "exampleResourceGroup"
            }
        }
    ]
}
	count(result) == 1
}
