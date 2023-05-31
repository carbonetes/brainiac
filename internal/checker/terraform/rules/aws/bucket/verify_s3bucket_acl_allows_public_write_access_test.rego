package lib.terraform.CB_TFAWS_055

test_s3_bucket_acl_no_allows_public_write {
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

test_s3_bucket_acl_allows_public_write {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_s3_bucket",
                        "example"
                        ],
                        "Attributes": {
                        "acl": "public-read-write",
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