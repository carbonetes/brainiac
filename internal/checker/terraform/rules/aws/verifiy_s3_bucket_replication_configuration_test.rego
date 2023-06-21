package lib.terraform.CB_TFAWS_149

test_verifiy_s3_bucket_replication_configuration_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket",
                                    "test"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "replication_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "rules",
                                        "Labels": [],
                                        "Attributes": {
                                        "status": "Enabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 3
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verifiy_s3_bucket_replication_configuration_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_s3_bucket",
                                    "test"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "replication_configuration",
                                        "Labels": [],
                                        "Attributes": {},
                                        "Blocks": [
                                        {
                                        "Type": "rules",
                                        "Labels": [],
                                        "Attributes": {
                                        "status": "Disabled"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 3
                                        }
                                        }
                                        ],
                                        "line_range": {
                                        "endLine": 6,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 7,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}