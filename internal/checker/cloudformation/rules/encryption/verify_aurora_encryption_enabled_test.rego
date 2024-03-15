package lib.cloudformation.CB_CFT_071

test_aurora_has_encryption_enabled {
    result := passed with input as {
        "Resources": {
            "AuroraDBCluster": {
                "Type": "AWS::RDS::DBCluster",
                "Properties": {
                    "StorageEncrypted": true
                }
            }
        }
    }
    count(result) == 1
}

test_aurora_does_not_have_encryption_enabled {
    result := failed with input as {
        "Resources": {
            "AuroraDBCluster": {
                "Type": "AWS::RDS::DBCluster",
                "Properties": {
                    "StorageEncrypted": false
                }
            }
        }
    }
    count(result) == 1
}
