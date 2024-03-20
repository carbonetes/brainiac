package lib.azurearm.CB_AZR_058

test_vm_scale_sets_encrypted_at_host_pass {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Compute/virtualMachines",
		"properties": {"securityProfile": {"encryptionAtHost": "True"}},
	}]}
	count(result) == 1
}

test_vm_scale_sets_not_encrypted_at_host_fail {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Compute/virtualMachines",
		"properties": {"securityProfile": {"encryptionAtHost": "False"}},
	}]}
	count(result) == 1
}
