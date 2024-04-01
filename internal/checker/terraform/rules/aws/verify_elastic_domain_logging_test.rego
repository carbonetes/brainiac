package lib.terraform.CB_TFAWS_080
import rego.v1

test_verify_elastic_domain_logging_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "monitoring-framework"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "log_publishing_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "cloudwatch_log_group_arn": "aws_cloudwatch_log_group.example.arn",
                                        "enabled": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
                                    
    count(result) == 1
}

test_verify_elastic_domain_logging_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "monitoring-framework"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "log_publishing_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "cloudwatch_log_group_arn": "aws_cloudwatch_log_group.example.arn",
                                        "enabled": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 5,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 6,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}