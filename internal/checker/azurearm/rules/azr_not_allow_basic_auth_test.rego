package lib.azurearm.CB_AZR_001

test_azr_intance_does_not_allow_basic_auth {
	result := passed with input as {
		"$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
		"contentVersion": "1.0.0.0",
		"resources": [{
			"type": "Microsoft.Compute/virtualMachines",
			"apiVersion": "2022-03-01",
			"name": "myVM",
			"location": "East US",
			"properties": {
				"hardwareProfile": {"vmSize": "Standard_DS2_v2"},
				"osProfile": {
					"computerName": "myVM",
					"adminUsername": "azureuser",
					"linuxConfiguration": {
						"disablePasswordAuthentication": true,
						"ssh": {"publicKeys": [{
							"path": "/home/azureuser/.ssh/authorized_keys",
							"keyData": "<SSH Public Key>",
						}]},
					},
				},
				"storageProfile": {
					"imageReference": {
						"publisher": "Canonical",
						"offer": "UbuntuServer",
						"sku": "18.04-LTS",
						"version": "latest",
					},
					"osDisk": {"createOption": "FromImage"},
				},
				"networkProfile": {"networkInterfaces": [{"id": "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/networkInterfaces/{nic-name}"}]},
			},
		}],
	}

	count(result) == 1
}

test_azr_intance_does_allow_basic_auth {
	result := failed with input as {
		"$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
		"contentVersion": "1.0.0.0",
		"resources": [{
			"type": "Microsoft.Compute/virtualMachines",
			"apiVersion": "2022-03-01",
			"name": "myVM",
			"location": "East US",
			"properties": {
				"hardwareProfile": {"vmSize": "Standard_DS2_v2"},
				"osProfile": {
					"computerName": "myVM",
					"adminUsername": "azureuser",
					"linuxConfiguration": {
						"disablePasswordAuthentication": false,
						"ssh": {"publicKeys": [{
							"path": "/home/azureuser/.ssh/authorized_keys",
							"keyData": "<SSH Public Key>",
						}]},
					},
				},
				"storageProfile": {
					"imageReference": {
						"publisher": "Canonical",
						"offer": "UbuntuServer",
						"sku": "18.04-LTS",
						"version": "latest",
					},
					"osDisk": {"createOption": "FromImage"},
				},
				"networkProfile": {"networkInterfaces": [{"id": "/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.Network/networkInterfaces/{nic-name}"}]},
			},
		}],
	}

	count(result) == 1
}
