package lib.cloudformation.CB_CFT_008

test_rds_is_not_publicly_accessible {
    result := passed with input as {"Resources": {"RDSAccess": {
        "Type": "AWS::RDS::DBInstance",
        "Properties": {
            "PubliclyAccessible": false,
        },
    }}}
    count(result) == 1
}

test_rds_is_publicly_accessible {
    result := failed with input as {"Resources": {"RDSAccess": {
        "Type": "AWS::RDS::DBInstance",
        "Properties": {
            "PubliclyAccessible": true,
        },
    }}}
    count(result) == 1
}
