package lib.azurearm.CB_AZR_023

test_auditing_sql_servers_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {"state": "Enabled"},
	}]}
    count(result) == 1
}

test_auditing_sql_servers_not_enabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {"state": "Disabled"},
	}]}
    count(result) == 1
}

