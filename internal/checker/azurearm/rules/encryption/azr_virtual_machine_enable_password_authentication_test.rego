package lib.azurearm.CB_AZR_074

test_azr_virtual_machine_enable_password_authentication_disabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Compute/virtualMachineScaleSets",
                "properties": {
                    "virtualMachineProfile": {
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

test_azr_virtual_machine_enable_password_authentication_enabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Compute/virtualMachineScaleSets",
                "properties": {
                    "virtualMachineProfile": {
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
