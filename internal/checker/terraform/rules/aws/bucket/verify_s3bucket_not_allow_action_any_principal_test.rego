package lib.terraform.CB_TFAWS_077
import rego.v1

test_s3_bucket_not_allow_action_any if {
    result := passed with input as[
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_s3_bucket_policy",
                                "example_bucket_policy"
                                ],
                                "Attributes": {
                                "bucket": "aws_s3_bucket.example_bucket.id",
                                "policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"DisallowAnyPrincipal\",\n      \"Effect\": \"Deny\",\n      \"Principal\": \"*\",\n      \"Action\": \"*\"\n    }\n  ]\n}\n"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 22,
                                "startLine": 6
                                }
                                }
                            ]
    count(result) == 1
}

test_s3_bucket_allow_action_any if {
    result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_s3_bucket_policy",
                                "example_bucket_policy"
                                ],
                                "Attributes": {
                                "bucket": "aws_s3_bucket.example_bucket.id",
                                "policy": "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"DisallowAnyPrincipal\",\n      \"Effect\": \"Allow\",\n      \"Principal\": \"*\",\n      \"Action\": \"*\"\n    }\n  ]\n}\n"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 22,
                                "startLine": 6
                                }
                                }
                            ]
    count(result) == 1
}