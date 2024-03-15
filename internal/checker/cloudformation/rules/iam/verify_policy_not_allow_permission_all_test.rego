package lib.cloudformation.CB_CFT_043

test_verify_policy_not_allow_permission_all_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMRole": {
                "Type": "AWS::IAM::Role",
                "Properties": {
                    "AssumeRolePolicyDocument": {
                        "Statement": [
                            {                              
                                "Effect": "Allow",
                                "Principal": {
                                    "AWS": [
                                        "arn:aws:iam::444455556666:role/another-allowed-role",
                                        "arn:aws:iam::111122223333:role/allowed-role"
                                    ]
    }}]},}}}}
    count(result) == 1
}

test_verify_policy_not_allow_permission_all_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMRole": {
                "Type": "AWS::IAM::Role",
                "Properties": {
                    "AssumeRolePolicyDocument": {
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Principal": {
                                    "AWS": ["*"]
    }}]},}}}}
    count(result) == 1
}
