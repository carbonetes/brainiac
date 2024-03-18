package lib.azurearm.CB_AZR_002

test_azr_disk_encryption_enabled_pass {
	result := passed with input as {
		  "resources": [{
            "type": "Microsoft.Compute/disks",
            "properties": {
                "encryption": {
                    "diskEncryptionSetId": "yourDiskEncryptionSetId",
                    "type": "yourEncryptionType"
                },
                "encryptionSettingsCollection": {
                    "enabled": true,
                    "encryptionSettings": [
                        {
                        "diskEncryptionKey": {
                            "secretUrl": "yourSecretUrl",
                            "sourceVault": {
                            "id": "yourSourceVaultId"
                            }
                        },
                        "keyEncryptionKey": {
                            "keyUrl": "yourKeyUrl",
                            "sourceVault": {
                            "id": "yourSourceVaultId"
                            }
                        }
                        }
                    ],
                },
            }
        }]
	}
	count(result) == 1
}

test_azr_disk_encryption_enabled_fail {
	result := failed with input as {
		  "resources": [{
            "type": "Microsoft.Compute/disks",
            "properties": {
                "encryptionSettingsCollection": {
                    "enabled": false,
                    "encryptionSettings": [
                        {
                        "diskEncryptionKey": {
                            "secretUrl": "yourSecretUrl",
                            "sourceVault": {
                            "id": "yourSourceVaultId"
                            }
                        },
                        "keyEncryptionKey": {
                            "keyUrl": "yourKeyUrl",
                            "sourceVault": {
                            "id": "yourSourceVaultId"
                            }
                        }
                        }
                    ],
                },
            }
        }]
	}

	count(result) == 1
}
