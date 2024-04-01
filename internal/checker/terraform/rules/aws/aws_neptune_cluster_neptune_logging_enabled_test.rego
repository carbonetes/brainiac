package lib.terraform.CB_TFAWS_070
import rego.v1

test_aws_neptune_cluster_neptune_logging_enabled_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_neptune_cluster",
                        "example"
                        ],
                        "Attributes": {
                        "enable_cloudwatch_logs_exports": [
                            "audit"
                        ]
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 5,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_neptune_cluster_neptune_logging_enabled_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_neptune_cluster",
                        "example"
                        ],
                        "Attributes": {
                        "enable_cloudwatch_logs_exports": [
                            "error"
                        ]
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 5,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}