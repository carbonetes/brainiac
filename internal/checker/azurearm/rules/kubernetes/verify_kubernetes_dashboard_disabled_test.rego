package lib.azurearm.CB_AZR_008

test_kubernetes_dashboard_disabled_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2021-03-01",
            "properties": {
                "addonProfiles": {
                "KubeDashboard": {
                    "enabled": false 
                }
                }
            }
        }]
	}
	count(result) == 1
}

test_kubernetes_dashboard_disabled_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2017-08-31",
            "properties": {
                "addonProfiles": {
                "KubeDashboard": {
                    "enabled": true 
                }
                }
            }
        }]
	}

	count(result) == 1
}
