package lib.terraform.CB_TFAWS_058
import rego.v1

test_aws_iam_role_test_specific_principals_passed if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role",
                            "example"
                            ],
                            "Attributes": {
                            "assume_role_policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Deny\",\n      \"Principal\": {\n        \"AWS\": \"*\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n",
                            "name": "example_role"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 17,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_aws_iam_role_test_specific_principals_failed if {
    result := failed with input as[
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role",
                            "example"
                            ],
                            "Attributes": {
                            "assume_role_policy": "{\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"AWS\": \"*\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n",
                            "name": "example_role"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 17,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}