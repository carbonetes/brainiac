package lib.cloudformation.CB_CFT_083

test_verify_policy_not_allow_permission_without_constraints_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::ManagedPolicy",
                "Properties": {
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": ["acm-pca:CreatePermission"],
                                "Effect": "Deny",
                                "Resource": "foo"
                            },

                        ],
                    },
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_not_allow_permission_without_constraints_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::ManagedPolicy",
                "Properties": {
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": ["acm-pca:CreatePermission"],
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
