package lib.terraform.CB_TFAWS_312

import rego.v1

test_verify_aws_elasticache_cluster_custom_subnet_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_rds_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enabled_cloudwatch_logs_exports": [
                    "audit",
                    "error",
                    "general",
                    "slowquery"
                ]
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        }
    ]
                                    
    count(result) == 1
}

test_verify_aws_elasticache_cluster_custom_subnet_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_rds_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enabled_cloudwatch_logs_exports": []
            },
            "Blocks": [],
            "line_range": {
                "endLine": 8,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}