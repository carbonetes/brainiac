package lib.terraform.CB_TFAWS_068
import rego.v1

test_verify_elasticsearch_domain_enforce_https_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "example_elasticsearch_domain"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "domain_endpoint_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "enforce_https": true
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 15
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 18,
                                    "startLine": 14
                                    }
                                    }
                                    ]
                                    
    count(result) == 1
}

test_verify_elasticsearch_domain_enforce_https_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "example_elasticsearch_domain"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "domain_endpoint_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "enforce_https": false
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 17,
                                        "startLine": 15
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 18,
                                    "startLine": 14
                                    }
                                    }
                                    ]
    count(result) == 1
}