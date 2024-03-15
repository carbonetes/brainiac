package lib.cloudformation.CB_CFT_023

test_kms_key_policy_no_wildcard_passed {
    result := passed with input as {
        "Resources": {
            "MyKMSKey": {
                "Type": "AWS::KMS::Key",
                "Properties": {
                    "KeyPolicy": {
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Principal": {
                                    "AWS": "arn:aws:iam::${AWS::AccountId}:root"
    }}]}}}}}
    count(result) == 1
}

test_kms_key_policy_no_wildcard_failed {
    result := failed with input as {
        "Resources": {
            "MyKMSKey": {
                "Type": "AWS::KMS::Key",
                "Properties": {
                    "KeyPolicy": {
                        "Statement": [
                            {
                                "Effect": "Deny",
                                "Principal": {
                                    "AWS": "*"
    }}]}}}}}
    count(result) == 1
}
