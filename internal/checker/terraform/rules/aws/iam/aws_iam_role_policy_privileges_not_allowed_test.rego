package lib.terraform.CB_TFAWS_061
import rego.v1

test_aws_iam_role_policy_privileges_not_allowed_passed if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role_policy",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example",
                            "path": "/",
                            "policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Deny\",\n      \"Action\": \"*\",\n      \"Resource\": \"*\"\n    }\n  ],\n  \"Version\": \"2012-10-17\"\n}\n"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 16,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_aws_iam_role_policy_privileges_not_allowed_failed if {
    result := failed with input as[
                             {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role_policy",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example",
                            "path": "/",
                            "policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"*\",\n      \"Resource\": \"*\"\n    }\n  ],\n  \"Version\": \"2012-10-17\"\n}\n"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 16,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}