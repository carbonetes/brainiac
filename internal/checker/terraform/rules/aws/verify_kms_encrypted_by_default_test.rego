package lib.terraform.CB_TFAWS_150
import rego.v1

test_verify_kms_encrypted_by_default_passed if {
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
                                        "Type": "server_side_encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "rule",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                            "Type": "apply_server_side_encryption_by_default",
                                            "Labels": [],
                                            "Attributes": {
                                            "sse_algorithm": "aws:kms"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                            "endLine": 6,
                                            "startLine": 4
                                            }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 3
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_kms_encrypted_by_default_passed_failed if {
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
                                        "Type": "server_side_encryption_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "rule",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                            "Type": "apply_server_side_encryption_by_default",
                                            "Labels": [],
                                            "Attributes": {
                                            "sse_algorithm": "tc"
                                            },
                                            "Blocks": [],
                                            "line_range": {
                                            "endLine": 6,
                                            "startLine": 4
                                            }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 7,
                                        "startLine": 3
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 8,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 9,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}