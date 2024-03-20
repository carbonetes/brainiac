package lib.azurearm.CB_AZR_051

test_latest_net_framework {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Web/sites/config",
		"properties": {"netFrameworkVersion": "v7.0"},
	}]}
	count(result) == 1
}

test_outdated_net_framework {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Web/sites/config",
		"properties": {"netFrameworkVersion": "v1.0"},
	}]}

	count(result) == 1
}
