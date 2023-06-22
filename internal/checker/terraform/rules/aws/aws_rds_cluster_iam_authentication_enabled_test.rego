package lib.terraform.CB_TFAWS_153

test_rds_cluster_iam_authentication_enabled_passed {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_rds_cluster",
                                "enabled"
                                ],
                                "Attributes": {
                                "iam_database_authentication_enabled": true
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

test_rds_cluster_iam_authentication_enabled_failed {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_rds_cluster",
                                "enabled"
                                ],
                                "Attributes": {
                                "iam_database_authentication_enabled": false
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