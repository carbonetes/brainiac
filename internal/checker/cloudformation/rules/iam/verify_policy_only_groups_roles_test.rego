package lib.cloudformation.CB_CFT_31

test_verify_policy_only_groups_or_roles_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "Groups": ["MyIAMGroup"],
                    "PolicyName": "MyIAMPolicy",
                    "Roles": ["MyIAMRole"],
                    "Users": [""]
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_only_groups_or_roles_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "Groups": ["MyIAMGroup"],
                    "PolicyName": "MyIAMPolicy",
                    "Roles": ["MyIAMRole"],
                    "Users": ["User1"]
                }
            }
        }
    }
    count(result) == 1
}
