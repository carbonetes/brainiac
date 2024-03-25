package lib.azurearm.CB_AZR_062

test_azr_api_services_use_virtual_networks_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.ApiManagement/service",
            "apiVersion": "2021-01-01-preview",
            "properties": {
                "virtualNetworkType": "External",
                "virtualNetworkConfiguration": {
                    "subnetResourceId": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworkName'), parameters('subnetName'))]"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_api_services_use_virtual_networks_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.ApiManagement/service",
            "apiVersion": "2021-01-01-preview",
            "properties": {
                "virtualNetworkType": "External",
                }
            }
        ]
    }
	count(result) == 1
}