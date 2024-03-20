package lib.azurearm.CB_AZR_045

test_azr_virtual_machine_extensions_not_installed_pass{
	result := passed with input as {
       "resources": [
            {
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2023-09-01",
            "properties": {
                "osProfile": {
                    "allowExtensionOperations": false
                }
            }
            }
        ]
}
	count(result) == 1
}

test_azr_virtual_machine_extensions_not_installed_fail{
	result := failed with input as {
       "resources": [
            {
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2023-09-01",
            "properties": {
                "osProfile": {
                    "allowExtensionOperations": true
                }
            }
            }
        ]
}
	count(result) == 1
}
