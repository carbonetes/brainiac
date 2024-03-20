package lib.azurearm.CB_AZR_046

test_azr_synapse_enabled_virtual_network_pass {
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Synapse/workspaces",
            "apiVersion": "2021-11-01-preview",
                "properties": {
                    "azureADOnlyAuthentication": false,
                    "managedVirtualNetwork": {
                    "type": "SystemAssigned",
                    "virtualNetworkSubnetId": "[resourceId('Microsoft.Network/virtualNetworks/subnets', parameters('virtualNetworkName'), parameters('subnetName'))]"
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_synapse_enabled_virtual_network_fail {
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Synapse/workspaces",
            "apiVersion": "2021-11-01-preview",
                "properties": {
                    "azureADOnlyAuthentication": false,
                }
            }
        ]
    }
	count(result) == 1
}