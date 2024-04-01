package lib.terraform.CB_TFAWS_304

import rego.v1 

test_verify_elasticsearch_domain_audit_logging_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticsearch_domain",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "log_publishing_options",
                    "Labels": [],
                    "Attributes": {
                        "enabled": true,
                        "log_type": "AUDIT_LOGS"
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

test_verify_elasticsearch_domain_audit_logging_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticsearch_domain",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "log_publishing_options",
                    "Labels": [],
                    "Attributes": {
                        "enabled": false,
                        "log_type": "AUDIT_LOGS"
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