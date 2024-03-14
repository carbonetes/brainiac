package lib.cloudformation.CB_CFT_075

test_neptune_db_cluster_logs_enabled_pass {
    result := passed with input as {
        "Resources": {
            "NeptuneDBCluster": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "BackupRetentionPeriod": 7,
                    "DBSubnetGroupName": "YourDBSubnetGroup",
                    "EnableCloudwatchLogsExports": [
                        "audit"
                    ],
                }
            }
        }
    }
    count(result) == 1
}

test_neptune_db_cluster_logs_enabled_fail {
    result := failed with input as {
        "Resources": {
            "NeptuneDBCluster": {
                "Type": "AWS::Neptune::DBCluster",
                "Properties": {
                    "BackupRetentionPeriod": 7,
                    "DBSubnetGroupName": "YourDBSubnetGroup",
                    "EnableCloudwatchLogsExports": [
                        ""
                    ],
                }
            }
        }
    }
    count(result) == 1
}