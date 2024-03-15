package lib.cloudformation.CB_CFT_082

test_verify_policy_not_allow_privilege_escalation_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::User",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Action": ["iam:CreateAccessKey"],
                                        "Effect": "Deny",
                                    }
                                ],
                            },
                        }
                    ],
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_not_allow_privilege_escalation_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::User",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Action": ["iam:CreateAccessKey"],
                                        "Effect": "Allow",
                                    }
                                ],
                            },
                        }
                    ],
                }
            }
        }
    }
    count(result) == 1
}
