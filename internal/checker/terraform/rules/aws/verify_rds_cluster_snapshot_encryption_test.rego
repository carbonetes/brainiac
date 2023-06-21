package lib.terraform.CB_TFAWS_151

test_verify_rds_cluster_snapshot_encryption_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_db_cluster_snapshot",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "storage_encrypted": true
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verify_rds_cluster_snapshot_encryption_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_db_cluster_snapshot",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "storage_encrypted": false
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}