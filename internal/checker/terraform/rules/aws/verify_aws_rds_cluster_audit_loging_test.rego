package lib.terraform.CB_TFAWS_314

import rego.v1 

test_verify_aws_rds_cluster_audit_loging_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_rds_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enabled_cloudwatch_logs_exports": [
                    "audit"
                ],
                "engine": "aurora"
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

test_verify_aws_rds_cluster_audit_loging_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_rds_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enabled_cloudwatch_logs_exports": [
                    "profile"
                ],
                "engine": "aurora"
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