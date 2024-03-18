package lib.azurearm.CB_AZR_007

test_aks_network_policy_configured_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2019-09-31",
            "properties": {
                "networkProfile": {
                    "networkPolicy": "Azure"
                }
            }
        }]
	}
	count(result) == 1
}

test_aks_network_policy_configured_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2017-08-31",
            "properties": {}
        }]
	}

	count(result) == 1
}
