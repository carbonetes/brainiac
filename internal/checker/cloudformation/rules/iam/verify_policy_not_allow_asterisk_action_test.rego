package lib.cloudformation.CB_CFT_045

test_verify_policy_not_allow_asterisk_statement_action_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Group",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Action": ["*"],
                                        "Effect": "Deny"
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

test_verify_policy_not_allow_asterisk_statement_action_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMPolicy": {
                "Type": "AWS::IAM::Group",
                "Properties": {
                    "Policies": [
                        {
                            "PolicyDocument": {
                                "Statement": [
                                    {
                                        "Action": ["*"],
                                        "Effect": "Allow"
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
