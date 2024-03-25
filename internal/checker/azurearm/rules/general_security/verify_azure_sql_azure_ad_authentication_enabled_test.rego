package lib.azurearm.CB_AZR_080

test_azure_sql_azure_ad_authentication_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {"administratorLogin": "Admin"},
	}]}
	count(result) == 1
}

test_azure_sql_azure_ad_authentication_disabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Sql/servers",
		"properties": {"administratorLogin": ""},
	}]}
	count(result) == 1
}
