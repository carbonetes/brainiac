package lib.azurearm.CB_AZR_003

test_support_https_traffic_only_true_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2019-06-01",
            "properties": {
                "supportsHttpsTrafficOnly": "true"
            }
        }]
	}
	count(result) == 1
}

test_support_https_traffic_only_true_fail {
	result := failed with input as {
       "resources": [{
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2018-06-01",
            "properties": {
                "supportsHttpsTrafficOnly": "false"
            }
        }]
	}

	count(result) == 1
}
