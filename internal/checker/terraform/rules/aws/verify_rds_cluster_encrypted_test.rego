package lib.terraform.CB_TFAWS_143

test_verify_rds_cluster_encrypted_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_global_cluster",
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

test_verify_rds_cluster_encrypted_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_global_cluster",
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