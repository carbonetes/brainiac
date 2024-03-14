package lib.cloudformation.CB_CFT_118

test_verify_documentdb_backup_retention_period_equal_or_greater_than_seven {
    result := passed with input as {"Resources": {
        "MyDocDBCluster": {
            "Type": "AWS::DocDB::DBCluster",
            "Properties": {
                "BackupRetentionPeriod": 7
            }
        }
    }
}
        count(result) == 1
}

test_verify_documentdb_backup_retention_period_not_equal_or_greater_than_seven{
    result := failed with input as {"Resources": {
        "MyDocDBCluster": {
            "Type": "AWS::DocDB::DBCluster",
            "Properties": {
                "BackupRetentionPeriod": 1
            }
        }
    }
}
        count(result) == 1
}