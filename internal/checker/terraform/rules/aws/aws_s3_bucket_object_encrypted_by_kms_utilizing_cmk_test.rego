package lib.terraform.CB_TFAWS_177

test_aws_s3_bucket_object_encrypted_by_kms_utilizing_cmk_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket_object",
                                    "object"
                                    ],
                                    "Attributes": {
                                    "bucket": "your_bucket_name",
                                    "key": "new_object_key",
                                    "kms_key_id": "ckv_kms",
                                    "source": "path/to/file"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 11,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_s3_bucket_object_encrypted_by_kms_utilizing_cmk_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket_object",
                                    "object"
                                    ],
                                    "Attributes": {
                                    "bucket": "your_bucket_name",
                                    "key": "new_object_key",
                                    "kms_key_id": "",
                                    "source": "path/to/file"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 11,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
