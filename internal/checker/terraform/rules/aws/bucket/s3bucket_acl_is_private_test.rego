package lib.terraform.CB_TFAWS_037

test_s3_bucket_acl_private {
    result := passed with input as[
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_s3_bucket",
                        "example"
                        ],
                        "Attributes": {
                        "acl": "private",
                        "bucket": "example-bucket"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_s3_bucket_acl_public {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_s3_bucket",
                        "example"
                        ],
                        "Attributes": {
                        "acl": "public-read",
                        "bucket": "example-bucket"
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}