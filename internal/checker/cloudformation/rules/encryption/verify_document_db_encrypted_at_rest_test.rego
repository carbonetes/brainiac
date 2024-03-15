package lib.cloudformation.CB_CFT_054

test_verify_document_db_encryption_at_rest_enabled {
    result := passed with input as {"Resources": {
        "MyDocDBCluster": {
            "Type": "AWS::DocDB::DBCluster",
            "Properties": {
                "DBClusterIdentifier": "<your-cluster-identifier>",
                "StorageEncrypted": true
            }
        }
    }
}
        count(result) == 1
}

test_verify_document_db_encryption_at_disabled {
    result := failed with input as {"Resources": {
        "MyDocDBCluster": {
            "Type": "AWS::DocDB::DBCluster",
            "Properties": {
                "DBClusterIdentifier": "<your-cluster-identifier>",
                "StorageEncrypted": false
            }
        }
    }
}
        count(result) == 1
}