package lib.cloudformation.CB_CFT_119

test_neptune_backup_retention_passed {
    result := passed with input as {
        "Resources": {
            "NeptuneDBCluster": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "BackupRetentionPeriod": 7,                
                }
            }
        }
    }
    count(result) == 1
}

test_neptune_backup_retention_failed {
    result := failed with input as {
               "Resources": {
            "NeptuneDBCluster": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "BackupRetentionPeriod": 6,                
                }
            }
        }
    }
    count(result) == 1
}
