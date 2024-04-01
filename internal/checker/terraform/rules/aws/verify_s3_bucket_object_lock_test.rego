package lib.terraform.CB_TFAWS_147
import rego.v1

test_verify_s3_bucket_object_lock_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket",
                                    "example_bucket"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "object_lock_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "object_lock_enabled": "Enabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_s3_bucket_object_lock_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket",
                                    "example_bucket"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "object_lock_configuration",
                                        "Labels": [],
                                        "Attributes": {
                                        "object_lock_enabled": "Disabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}