package lib.azurearm.CB_AZR_056

test_automatic_os_patching_enabled {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Compute/virtualMachineScaleSets",
		"properties": {"enableAutomaticUpgrade": true},
	}]}
	count(result) == 1
}

test_automatic_os_patching_disabled {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Compute/virtualMachineScaleSets",
		"properties": {"enableAutomaticUpgrade": false},
	}]}
	count(result) == 1
}
