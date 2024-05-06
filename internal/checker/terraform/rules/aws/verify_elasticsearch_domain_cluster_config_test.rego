package lib.terraform.CB_TFAWS_306

import rego.v1

test_verify_elasticsearch_domain_cluster_config_passed if {
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
                    "Type": "cluster_config",
                    "Labels": [],
                    "Attributes": {
                        "dedicated_master_count": "4",
                        "zone_awareness_enabled": true
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

test_verify_elasticsearch_domain_cluster_config_failed if {
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
                    "Type": "cluster_config",
                    "Labels": [],
                    "Attributes": {
                        "dedicated_master_count": "4",
                        "zone_awareness_enabled": false
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