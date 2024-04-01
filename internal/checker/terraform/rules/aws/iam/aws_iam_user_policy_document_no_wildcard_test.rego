package lib.terraform.CB_TFAWS_063
import rego.v1

test_aws_iam_user_policy_document_no_wildcard_passed if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_user_policy",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example",
                            "policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Deny\",\n      \"Action\": \"*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n",
                            "user": "aws_iam_user.example.name"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 15,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_aws_iam_user_policy_document_no_wildcard_failed if {
    result := failed with input as[
                             {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_user_policy",
                            "example"
                            ],
                            "Attributes": {
                            "name": "example",
                            "policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": \"*\",\n      \"Resource\": \"*\"\n    }\n  ]\n}\n",
                            "user": "aws_iam_user.example.name"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 15,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}