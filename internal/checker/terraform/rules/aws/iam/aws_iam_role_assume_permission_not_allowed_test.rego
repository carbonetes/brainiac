package lib.terraform.CB_TFAWS_064
import rego.v1

test_aws_iam_role_assume_permission_not_allowed_passed if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role",
                            "example"
                            ],
                            "Attributes": {
                            "assume_role_policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Deny\",\n      \"Principal\": {\n        \"AWS\": \"arn:aws:iam::123456789012:root\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n",
                            "name": "example_role"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 18,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_aws_iam_role_assume_permission_not_allowed_failed if {
    result := failed with input as[
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_iam_role",
                            "example"
                            ],
                            "Attributes": {
                            "assume_role_policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"AWS\": \"arn:aws:iam::123456789012:root\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n",
                            "name": "example_role"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 18,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}