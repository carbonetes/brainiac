package lib.terraform.CB_TFAWS_176
import rego.v1

test_aws_kinesis_stream_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_kinesis_stream",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "aws_kms_key.sse_aws_kms_key_id.id"
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

test_aws_kinesis_stream_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_kinesis_stream",
                                    "pass"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": ""
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
