package lib.terraform.CB_TFAWS_367

import rego.v1 

test_aws_elasticache_redis_configured_automatic_failover_passed if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_elasticache_replication_group",
            "pass"
        ],
        "Attributes": {
            "automatic_failover_enabled": true,
            "description": "example description",
            "node_type": "cache.m4.large",
            "num_cache_clusters": "2",
            "parameter_group_name": "default.redis3.2",
            "port": "6379",
            "preferred_cache_cluster_azs": [
                "us-west-2a",
                "us-west-2b"
            ],
            "replication_group_id": "tf-rep-group-1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_aws_elasticache_redis_configured_automatic_failover_failed if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "aws_elasticache_replication_group",
            "pass"
        ],
        "Attributes": {
            "automatic_failover_enabled": false,
            "description": "example description",
            "node_type": "cache.m4.large",
            "num_cache_clusters": "2",
            "parameter_group_name": "default.redis3.2",
            "port": "6379",
            "preferred_cache_cluster_azs": [
                "us-west-2a",
                "us-west-2b"
            ],
            "replication_group_id": "tf-rep-group-1"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 10,
            "startLine": 1
        }
    }
]
	count(result) == 1
}