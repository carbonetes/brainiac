package lib.terraform.CB_TFAWS_310

import rego.v1 

test_verify_aws_elasticache_cluster_automatic_minor_upgrade_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticache_cluster",
                "memcached_cluster"
            ],
            "Attributes": {
                "auto_minor_version_upgrade": true
            },
            "Blocks": [],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        }
    ]
                                    
    count(result) == 1
}

test_verify_aws_elasticache_cluster_automatic_minor_upgrade_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticache_cluster",
                "memcached_cluster"
            ],
            "Attributes": {
                "auto_minor_version_upgrade": false
            },
            "Blocks": [],
            "line_range": {
                "endLine": 3,
                "startLine": 1
            }
        }
    ]
    count(result) == 1
}