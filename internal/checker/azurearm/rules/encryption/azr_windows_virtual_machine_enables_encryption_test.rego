package lib.azurearm.CB_AZR_075

test_azr_windows_virtual_machine_enables_encryption_enabled {
	result := passed with input as {
        "resources": [
            {
                "type": "Microsoft.Compute/virtualMachines",
                "properties": {
                    "securityProfile": {
                        "encryptionAtHost": true
                    }
                }
            }
        ]
    }
	count(result) == 1
}

test_azr_windows_virtual_machine_enables_encryption_disabled {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.Compute/virtualMachines",
                "properties": {
                    "securityProfile": {
                        "encryptionAtHost": false
                    }
                }
            }
        ]
    }
	count(result) == 1
}
