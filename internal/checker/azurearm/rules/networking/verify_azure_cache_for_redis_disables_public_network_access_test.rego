package lib.azurearm.CB_AZR_053

test_azure_cache_redis_disabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Cache/redis",
		"properties": {"publicNetworkAccess": "Disabled"},
	}]}
	count(result) == 1
}

test_azure_cache_redis_enabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Cache/redis",
		"properties": {"publicNetworkAccess": "Enabled"},
	}]}
	count(result) == 1
}
