package lib.azurearm.CB_AZR_054

test_managed_disks_utilized_specified_encryption {
	result := passed with input as {"resources": [{
		"type": "Microsoft.Compute/disks",
		"properties": {"encryption": {"diskEncryptionSetId": "<disk-encryption-set-id>"}},
	}]}
	count(result) == 1
}

test_managed_disks_not_utilized_specified_encryption {
	result := failed with input as {"resources": [{
		"type": "Microsoft.Compute/disks",
		"properties": {"encryption": {"diskEncryptionSetId": ""}},
	}]}
	count(result) == 1
}
