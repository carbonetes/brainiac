package lib.terraform.CB_TFAWS_172
import rego.v1

test_aws_s3_object_copy_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_object_copy",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "bucket": "destination_bucket",
                                    "key": "destination_key",
                                    "kms_key_id": "aws_kms_key.foo.arn",
                                    "source": "source_bucket/source_key"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "grant",
                                        "Labels": [],
                                        "Attributes": {
                                        "permissions": [
                                        "READ"
                                        ],
                                        "type": "Group",
                                        "uri": "http://acs.amazonaws.com/groups/global/AllUsers"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 8
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_s3_object_copy_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_object_copy",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "bucket": "destination_bucket",
                                    "key": "destination_key",
                                    "kms_key_id": "",
                                    "source": "source_bucket/source_key"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "grant",
                                        "Labels": [],
                                        "Attributes": {
                                        "permissions": [
                                        "READ"
                                        ],
                                        "type": "Group",
                                        "uri": "http://acs.amazonaws.com/groups/global/AllUsers"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 12,
                                        "startLine": 8
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
