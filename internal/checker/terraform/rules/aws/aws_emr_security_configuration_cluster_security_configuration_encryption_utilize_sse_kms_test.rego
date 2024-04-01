package lib.terraform.CB_TFAWS_164
import rego.v1

test_aws_emr_security_configuration_cluster_security_configuration_encryption_utilize_sse_kms_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_emr_security_configuration",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "configuration": "{\n  \"EncryptionConfiguration\": {\n    \"AtRestEncryptionConfiguration\": {\n      \"S3EncryptionConfiguration\": {\n        \"EncryptionMode\": \"SSE-KMS\"\n      }\n    }\n  }\n}\n"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_emr_security_configuration_cluster_security_configuration_encryption_utilize_sse_kms_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_emr_security_configuration",
                                    "test"
                                    ],
                                    "Attributes": {
                                    "configuration": "{\n  \"EncryptionConfiguration\": {\n    \"AtRestEncryptionConfiguration\": {\n      \"S3EncryptionConfiguration\": {\n        \"EncryptionMode\": \"SSE-Other\"\n      }\n    }\n  }\n}\n"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
