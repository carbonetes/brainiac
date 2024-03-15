package lib.cloudformation.CB_CFT_101

test_verify_rds_cluster_auth_enabled_pass {
    result := passed with input as {
        "Resources": {
            "MyDBInstance": {
                "Type": "AWS::RDS::DBCluster",
                "Properties": {
                    "EnableIAMDatabaseAuthentication": true,
                }
            }
        }
    }
    count(result) == 1
}

test_verify_rds_cluster_auth_enabled_fail {
    result := failed with input as {
        "Resources": {
            "MyDBInstance": {
                "Type": "AWS::RDS::DBCluster",
                "Properties": {
                    "EnableIAMDatabaseAuthentication": false,
                }
            }
        }
    }
    count(result) == 1
}
