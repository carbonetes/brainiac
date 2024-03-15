package lib.cloudformation.CB_CFT_080

test_verify_policy_not_allow_data_exfiltration_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMUser": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Effect": "Allow",
                                        "Action": ["secretsmanager:GetSecretValue"],
                                        "Resource": "asdasd"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_not_allow_data_exfiltration_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMUser": {
                "Type": "AWS::IAM::Policy",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Effect": "Allow",
                                        "Action": ["rds:CreateDBSnapshot"],
                                        "Resource": "*"
                                    }
                                ]
                            }
                        }
                    ]
                }
            }
        }
    }
    count(result) == 1
}
