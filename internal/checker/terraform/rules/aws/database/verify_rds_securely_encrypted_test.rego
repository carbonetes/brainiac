package lib.terraform.CB_TFAWS_019

test_enable_rds_encryption_passed {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_db_instance",
                            "example"
                            ],
                            "Attributes": {
                            "storage_encrypted": true,
                            "storage_type": "gp2",
                            "username": "example"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 21,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}

test_enable_rds_encryption_faied {
result := failed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_db_instance",
                            "example"
                            ],
                            "Attributes": {
                            "storage_encrypted": false,
                            "storage_type": "gp2",
                            "username": "example"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 21,
                            "startLine": 1
                            }
                            }
                            ]
    count(result) == 1
}