package lib.cloudformation.CB_CFT_044

test_verify_policy_not_allow_full_admin_privilege_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": ["*"],
                                "Effect": "Deny",
                                "Resource": "*"
                            },

                        ],
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_not_allow_full_admin_privilege_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": ["*"],
                                "Effect": "Allow",
                                "Resource": "*"
                            },
                        ],
                    },
                }
            }
        }
    }
    count(result) == 1
}
