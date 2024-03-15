package lib.cloudformation.CB_CFT_097

test_multi_az_enabled_rds_instance {
	result := passed with input as {"Resources": {"MyDBInstance":{
        "Properties": {
            "MultiAZ": true
        },
        "Type": "AWS::RDS::DBInstance"
    }}}
	count(result) == 1
}

test_multi_az_not_enabled_rds_instance {
	result := failed with input as {"Resources": {"MyDBInstance":{
        "Properties": {
            "MultiAZ": false
        },
        "Type": "AWS::RDS::DBInstance"
    }}}
	count(result) == 1
}
