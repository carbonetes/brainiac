package lib.terraform.CB_TFAWS_087

test_aws_neptune_cluster_instance_public_restricted_passed {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_ssm_document",
                                "example"
                                ],
                                "Attributes": {
                                "content": "    {\n      \"inputs\": {\n        \"kmsKeyId\": \"your_kms_key_id\"\n      }\n    }\n",
                                "document_format": "JSON",
                                "document_type": "Session"
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

test_aws_neptune_cluster_instance_public_restricted_failed {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_ssm_document",
                                "example"
                                ],
                                "Attributes": {
                                "content": "    {\n      \"inputs\": {\n        \"invalidId\": \"your_kms_key_id\"\n      }\n    }\n",
                                "document_format": "JSON",
                                "document_type": "Session"
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