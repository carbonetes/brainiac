package lib.terraform.CB_TFAWS_142

test_verify_rds_deletion_protection_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "deletion_protection": true
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

test_verify_rds_deletion_protection_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_rds_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "deletion_protection": false
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