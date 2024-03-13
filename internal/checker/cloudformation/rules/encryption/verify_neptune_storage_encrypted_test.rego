package lib.cloudformation.CB_CFT_030

test_neptune_storage_is_encrypted_securely_pass{
    result := passed with input as {
        "Resources": {
            "MyKinesisStream": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "StorageEncrypted": true
                }
            }
        }
    }
    count(result) == 1
}

test_neptune_storage_is_encrypted_securely_fail{
    result := failed with input as {
        "Resources": {
            "MyKinesisStream": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "StorageEncrypted": false
                }
            }
        }
    }
    count(result) == 1
}
