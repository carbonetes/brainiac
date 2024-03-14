package lib.cloudformation.CB_CFT_105

test_backup_vault_encrypted_pass {
    result := passed with input as {
        "Resources": {
            "MyBackupVault": {
                "Type": "AWS::Backup::BackupVault",
                "Properties": {
                    "BackupVaultName": "MyBackupVault",
                    "EncryptionKeyArn": "your-KMS-CMK-ARN"
                }
            }
        }
    }
    count(result) == 1
}

test_backup_vault_encrypted_fail {
    result := failed with input as {
        "Resources": {
            "MyBackupVault": {
                "Type": "AWS::Backup::BackupVault",
                "Properties": {
                    "BackupVaultName": "MyBackupVault",
                    "EncryptionKeyArn": ""
                }
            }
        }
    }
    count(result) == 1
}
