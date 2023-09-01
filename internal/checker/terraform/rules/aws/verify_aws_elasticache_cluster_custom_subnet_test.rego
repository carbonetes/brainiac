package lib.terraform.CB_TFAWS_311

test_verify_aws_elasticache_cluster_custom_subnet_passed {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticache_cluster",
                "example_cache_cluster"
            ],
            "Attributes": {
                "subnet_group_name": "aws_elasticache_subnet_group.example_subnet_group.name"
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

test_verify_aws_elasticache_cluster_custom_subnet_failed {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_elasticache_cluster",
                "example_cache_cluster"
            ],
            "Attributes": {
                "subnet_group_name": ""
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