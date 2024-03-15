package lib.cloudformation.CB_CFT_042

test_verify_policy_only_groups_or_roles_pass {
    result := passed with input as {
        "Resources": {
            "MyIAMRole": {
                "Type": "AWS::IAM::Role",
                "Properties": {
                    "AssumeRolePolicyDocument": {
                        "Statement": [
                            {                              
                                "Effect": "Deny",
                                "Principal": {
                                    "AWS": [
                                        "arn:aws:iam::444455556666:role/another-allowed-role",
                                        "arn:aws:iam::111122223333:role/allowed-role"
                                    ]
    }}]},}}}}
    count(result) == 1
}

test_verify_policy_only_groups_or_roles_fail {
    result := failed with input as {
        "Resources": {
            "MyIAMRole": {
                "Type": "AWS::IAM::Role",
                "Properties": {
                    "AssumeRolePolicyDocument": {
                        "Statement": [
                            {
                                "Effect": "Deny",
                                "Principal": {
                                    "AWS": ["*"]
    }}]},}}}}
    count(result) == 1
}
