package lib.terraform.CB_TFAWS_175
import rego.v1

test_aws_efs_file_system_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_efs_file_system",
                                    "enabled"
                                    ],
                                    "Attributes": {
                                    "creation_token": "example",
                                    "kms_key_id": "arn:aws:kms:us-east-1:123456789012:key/your-kms-key-id"
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

test_aws_efs_file_system_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_efs_file_system",
                                    "enabled"
                                    ],
                                    "Attributes": {
                                    "creation_token": "example",
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
