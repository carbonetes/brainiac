package lib.terraform.CB_TFAWS_011
import rego.v1

test_enable_sns_encryption_passed if {
    result := passed with input as [
                                    {
                                        "Type": "resource",
                                        "Labels": [
                                            "aws_sns_topic",
                                            "example_sns_topic"
                                        ],
                                        "Attributes": {
                                            "kms_master_key_id": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-5678-90ab-cdef-ghlmnopqr",
                                            "name": "example-topic"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                            "endLine": 4,
                                            "startLine": 1
                                        }
                                    }
                                ]
    count(result) == 1
}

test_enable_sns_encryption_faied if {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_sns_topic",
                                        "example_sns_topic"
                                    ],
                                    "Attributes": {
                                        "name": "example-topic"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 4,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}
