package lib.cloudformation.CB_CFT_86

test_verify_policy_not_allow_permission_without_constraints_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::ManagedPolicy",
                "Properties": {
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": ["chime:DeleteVoiceConnectorTerminationCredentials"],
                                "Effect": "Allow",
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
                                "Action": ["something"],
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
