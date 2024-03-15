package lib.cloudformation.CB_CFT_079

test_verify_policy_not_allow_credential_exposed_pass {
    result := passed with input as {
        "Resources": {
            "MyManagedPolicy": {
                "Type": "AWS::IAM::ManagedPolicy",
                "Properties": {
                    "ManagedPolicyName": "EnsureNoCredentialExposurePolicy",
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": [
                                    "ecr:GetAuthorizationToken",
                                    "iam:UpdateAccessKey"
                                ],
                                "Effect": "Deny",
                                "Resource": "*"
                            }
                        ],
                    }
                }
            }
        }
    }
    count(result) == 1
}

test_verify_policy_not_allow_credential_exposed_fail {
    result := failed with input as {
        "Resources": {
            "MyManagedPolicy": {
                "Type": "AWS::IAM::ManagedPolicy",
                "Properties": {
                    "ManagedPolicyName": "EnsureNoCredentialExposurePolicy",
                    "PolicyDocument": {
                        "Statement": [
                            {
                                "Action": [
                                    "ecr:GetAuthorizationToken",
                                    "iam:UpdateAccessKey"
                                ],
                                "Effect": "Allow",
                                "Resource": "*"
                            }
                        ],
                    }
                }
            }
        }
    }
    count(result) == 1
}
