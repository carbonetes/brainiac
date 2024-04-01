package lib.terraform.CB_TFAWS_013
import rego.v1

test_password_reuse_prevention_is_set if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_account_password_policy",
                            "example"
                            ],
                            "Attributes": {
                            "allow_users_to_change_password": true,
                            "password_reuse_prevention": "24",
                            "minimum_password_length": "14",
                            "require_lowercase_characters": true,
                            "require_numbers": true,
                            "require_symbols": true,
                            "require_uppercase_characters": true
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 122,
                            "startLine": 114
                            }
                            }
                            ]
    count(result) == 1
}

test_password_reuse_prevention_is_not_set if {
    result := failed with input as[
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_account_password_policy",
                            "example"
                            ],
                            "Attributes": {
                            "allow_users_to_change_password": true,
                            "minimum_password_length": "8",
                            "require_lowercase_characters": false,
                            "require_numbers": false,
                            "require_symbols": true,
                            "require_uppercase_characters": true
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 122,
                            "startLine": 114
                            }
                            }
                            ]
    count(result) == 1
}