package lib.terraform.CB_TFAWS_215
import rego.v1

test_aws_elasticsearch_domain_tls_policy_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "pass"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "domain_endpoint_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "tls_security_policy": "Policy-Min-TLS-1-2-2019-07"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_aws_elasticsearch_domain_tls_policy_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticsearch_domain",
                                    "pass"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [
                                    {
                                        "Type": "domain_endpoint_options",
                                        "Labels": [],
                                        "Attributes": {
                                        "tls_security_policy": ""
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 4,
                                        "startLine": 2
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 5,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}