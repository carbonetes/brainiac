package lib.azurearm.CB_AZR_044

test_azr_linux_not_use_basic_auth_pass{
	result := passed with input as {
        "resources": [
            {
            "type": "Microsoft.Compute/virtualMachineScaleSets",
            "apiVersion": "2020-12-01",
            "properties": {
                "virtualMachineProfile": {
                "storageProfile": {
                    "imageReference": {
                    "publisher": "linux"
                    }
                },
                "osProfile": {
                    "linuxConfiguration": {
                    "disablePasswordAuthentication": true
                    }
                }
                }
            }
            }
        ]
}
	count(result) == 1
}

test_azr_linux_not_use_basic_auth_fail{
	result := failed with input as {
        "resources": [
            {
            "type": "Microsoft.Compute/virtualMachineScaleSets",
            "apiVersion": "2020-12-01",
            "properties": {
                "virtualMachineProfile": {
                "storageProfile": {
                    "imageReference": {
                    "publisher": "windows"
                    }
                },
                "osProfile": {
                    "linuxConfiguration": {
                    "disablePasswordAuthentication": false
                    }
                }
                }
            }
            }
        ]
}
	count(result) == 1
}
