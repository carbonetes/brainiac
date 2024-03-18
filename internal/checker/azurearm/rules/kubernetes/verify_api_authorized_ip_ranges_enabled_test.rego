package lib.azurearm.CB_AZR_006

test_api_authorized_ip_ranges_enabled_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2019-02-01",
            "properties": {
                "apiServerAuthorizedIPRanges": "[parameters('apiServerAuthorizedIPRanges')]",
            }
        }]
	}
	count(result) == 1
}

test_api_authorized_ip_ranges_enabled_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2017-08-31",
            "properties": {
                "apiServerAuthorizedIPRanges": "[parameters('apiServerAuthorizedIPRanges')]",
                "apiServerAccessProfile": {
                "authorizedIPRanges": "[parameters('apiServerAuthorizedIPRanges')]"
                }
            }
        }]
	}

	count(result) == 1
}
