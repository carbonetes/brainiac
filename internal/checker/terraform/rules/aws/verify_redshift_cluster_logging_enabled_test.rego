package lib.terraform.CB_TFAWS_078
import rego.v1

test_redshift_cluster_logging_enabled if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_cluster",
                                "example_cluster"
                                ],
                                "Attributes": {},
                                "Blocks": [
                                {
                                    "Type": "logging",
                                    "Labels": [],
                                    "Attributes": {
                                    "bucket_name": "your-logging-bucket",
                                    "enable": true,
                                    "s3_key_prefix": "redshift-logs/",
                                    "s3_key_suffix": "/"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 4
                                    }
                                }
                                ],
                                "line_range": {
                                "endLine": 15,
                                "startLine": 1
                                }
                            }
                        ]
    count(result) == 1
}

test_redshift_cluster_logging_not_enabled if {
    result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_cluster",
                                "example_cluster"
                                ],
                                "Attributes": {},
                                "Blocks": [
                                {
                                    "Type": "logging",
                                    "Labels": [],
                                    "Attributes": {
                                    "bucket_name": "your-logging-bucket",
                                    "enable": false,
                                    "s3_key_prefix": "redshift-logs/",
                                    "s3_key_suffix": "/"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 4
                                    }
                                }
                                ],
                                "line_range": {
                                "endLine": 15,
                                "startLine": 1
                                }
                            }
                        ]
    count(result) == 1
}