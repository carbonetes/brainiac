package lib.azurearm.CB_AZR_005

test_rbac_is_enabled_aks_cluster_pass {
	result := passed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2018-05-21",
            "properties": {
                "enableRBAC": "true"
            }
        }]
	}
	count(result) == 1
}

test_rbac_is_enabled_aks_cluster_fail {
	result := failed with input as {
        "resources": [{
            "type": "Microsoft.ContainerService/managedClusters",
            "apiVersion": "2017-08-31",
            "properties": {
                "enableRBAC": "false"
            }
        }]
	}

	count(result) == 1
}
