package lib.cloudformation.CB_CFT_058

test_enforce_workgroup_configuration_true {
    result := passed with input as {"Resources": {
            "MyAthenaWorkgroup": {
                "Type": "AWS::Athena::WorkGroup",
                "Properties": {
                    "Configuration": {
                        "EnforceWorkGroupConfiguration": true
                    }
                }
            }
        }
    }

    count(result) == 1
}

test_enforce_workgroup_configuration_false {
    result := failed with input as {"Resources": {
            "MyAthenaWorkgroup": {
                "Type": "AWS::Athena::WorkGroup",
                "Properties": {
                    "Configuration": {
                        "EnforceWorkGroupConfiguration": false
                    }
                }
            }
        }
    }

    count(result) == 1
}