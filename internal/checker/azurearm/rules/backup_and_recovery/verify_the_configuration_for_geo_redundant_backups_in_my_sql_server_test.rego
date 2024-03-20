package lib.azurearm.CB_AZR_055

test_geo_redundant_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.DBforMySQL/flexibleServers",
		"properties": {"Backup": {"geoRedundantBackup": "Enabled"}},
	}]}
	count(result) == 1
}

test_geo_redundant_disabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.DBforMySQL/flexibleServers",
		"properties": {"Backup": {"geoRedundantBackup": "Disabled"}},
	}]}
	count(result) == 1
}
