package lib.terraform.CB_TFAWS_118
import rego.v1

test_aws_ssm_document_session_manager_logs_enabled_encrypted_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ssm_document",
                                    "s3_enabled_encrypted"
                                    ],
                                    "Attributes": {
                                    "content": "  {\n    \"schemaVersion\": \"1.0\",\n    \"description\": \"Document to hold regional settings for Session Manager\",\n    \"sessionType\": \"Standard_Stream\",\n    \"inputs\": {\n      \"s3BucketName\": \"example\",\n      \"s3KeyPrefix\": \"\",\n      \"s3EncryptionEnabled\": true,\n      \"cloudWatchLogGroupName\": \"\",\n      \"cloudWatchEncryptionEnabled\": true,\n      \"idleSessionTimeout\": \"20\",\n      \"cloudWatchStreamingEnabled\": true,\n      \"kmsKeyId\": \"\",\n      \"runAsEnabled\": false,\n      \"runAsDefaultUser\": \"\",\n      \"shellProfile\": {\n        \"windows\": \"\",\n        \"linux\": \"\"\n      }\n    }\n  }\n",
                                    "document_type": "Session",
                                    "name": "SSM-SessionManagerRunShell"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 28,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_ssm_document_session_manager_logs_enabled_encrypted_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_ssm_document",
                                    "s3_enabled_encrypted"
                                    ],
                                    "Attributes": {
                                    "content": "  {\n    \"schemaVersion\": \"1.0\",\n    \"description\": \"Document to hold regional settings for Session Manager\",\n    \"sessionType\": \"Standard_Stream\",\n    \"inputs\": {\n       \"s3KeyPrefix\": \"\",\n      \"s3EncryptionEnabled\": false,\n     \"cloudWatchEncryptionEnabled\": false,\n      \"idleSessionTimeout\": \"20\",\n      \"cloudWatchStreamingEnabled\": true,\n      \"kmsKeyId\": \"\",\n      \"runAsEnabled\": false,\n      \"runAsDefaultUser\": \"\",\n      \"shellProfile\": {\n        \"windows\": \"\",\n        \"linux\": \"\"\n      }\n    }\n  }\n",
                                    "document_type": "Session",
                                    "name": "SSM-SessionManagerRunShell"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 28,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
