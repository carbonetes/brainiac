package lib.terraform.CB_TFAWS_110
import rego.v1

test_verify_aurora_encryption_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "engine_mode": "serverless",
                                    "storage_encrypted": true
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

test_verify_aurora_encryption_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_cluster",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "engine_mode": "test",
                                    "storage_encrypted": false
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