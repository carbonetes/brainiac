package lib.azurearm.CB_AZR_004

test_azure_monitoring_configured_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2018-05-21",
            "properties": {
                "addonProfiles": {
                "omsagent": {
                    "enabled": true
                }
                }
            }
        }]
	}
	count(result) == 1
}

test_azure_monitoring_configured_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2017-08-31",
            "properties": {
                "addonProfiles": {
                "omsagent": {
                    "enabled": false
                }
                }
            }
        }]
	}

	count(result) == 1
}
