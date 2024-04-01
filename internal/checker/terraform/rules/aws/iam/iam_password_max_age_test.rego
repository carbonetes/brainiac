package lib.terraform.CB_TFAWS_008
import rego.v1

test_max_password_age_less_90 if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_account_password_policy",
                            "example"
                            ],
                            "Attributes": {
                            "allow_users_to_change_password": true,
                            "max_password_age": 90,
                            "minimum_password_length": "8",
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

test_max_password_age_greater_90 if {
    result := failed with input as[
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_account_password_policy",
                            "example"
                            ],
                            "Attributes": {
                            "allow_users_to_change_password": true,
                            "max_password_age": "91",
                            "minimum_password_length": "8",
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