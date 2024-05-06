package lib.terraform.CB_TFAWS_105
import rego.v1

test_verify_glue_data_catalog_encryption_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_data_catalog_encryption_settings",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "data_catalog_encryption_settings",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "connection_password_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        "aws_kms_key_id": "aws_kms_key.glue.arn",
                                        "return_connection_password_encrypted": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 3
                                        }
                                        },
                                        {
                                        "Type": "encryption_at_rest",
                                        "Labels": [],
                                        "Attributes": {
                                        "catalog_encryption_mode": "SSE-KMS",
                                        "sse_aws_kms_key_id": "aws_kms_key.glue.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 10,
                                        "startLine": 7
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_glue_data_catalog_encryption_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_glue_data_catalog_encryption_settings",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "data_catalog_encryption_settings",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "connection_password_encryption",
                                        "Labels": [],
                                        "Attributes": {
                                        "aws_kms_key_id": "aws_kms_key.glue.arn",
                                        "return_connection_password_encrypted": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 3
                                        }
                                        },
                                        {
                                        "Type": "encryption_at_rest",
                                        "Labels": [],
                                        "Attributes": {
                                        "catalog_encryption_mode": "SSE-KMS",
                                        "sse_aws_kms_key_id": "aws_kms_key.glue.arn"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 10,
                                        "startLine": 7
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}