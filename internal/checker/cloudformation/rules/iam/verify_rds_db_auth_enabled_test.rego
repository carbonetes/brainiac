package lib.cloudformation.CB_CFT_100

test_verify_rds_db_auth_enabled_pass {
    result := passed with input as {
        "Resources": {
            "MyDBInstance": {
                "Type": "AWS::RDS::DBInstance",
                "Properties": {
                    "EnableIAMDatabaseAuthentication": true,
                    "Engine": "mysql"
                }
            }
        }
    }
    count(result) == 1
}

test_verify_rds_db_auth_enabled_fail {
    result := failed with input as {
        "Resources": {
            "MyDBInstance": {
                "Type": "AWS::RDS::DBInstance",
                "Properties": {
                    "EnableIAMDatabaseAuthentication": false,
                    "Engine": "mysql"
                }
            }
        }
    }
    count(result) == 1
}
