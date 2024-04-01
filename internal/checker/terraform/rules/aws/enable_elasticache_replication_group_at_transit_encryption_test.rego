package lib.terraform.CB_TFAWS_020
import rego.v1

test_elasticache_replication_group_at_transit_encryption_passed if {
    result := passed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_elasticache_replication_group",
                                        "example_replication_group"
                                    ],
                                    "Attributes": {
                                        "transit_encryption_enabled": true,
                                        "automatic_failover_enabled": true,
                                        "engine": "redis",
                                        "engine_version": "5.0.6",
                                        "node_type": "cache.t2.micro",
                                        "num_node_groups": "1",
                                        "replication_group_description": "Example ElastiCache Replication Group",
                                        "replication_group_id": "example-replication-group"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 11,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}

test_elasticache_replication_group_at_transit_encryption_failed if {
result := failed with input as [
                                {
                                    "Type": "resource",
                                    "Labels": [
                                        "aws_elasticache_replication_group",
                                        "example_replication_group"
                                    ],
                                    "Attributes": {
                                        "transit_encryption_enabled": false,
                                        "automatic_failover_enabled": true,
                                        "engine": "redis",
                                        "engine_version": "5.0.6",
                                        "node_type": "cache.t2.micro",
                                        "num_node_groups": "1",
                                        "replication_group_description": "Example ElastiCache Replication Group",
                                        "replication_group_id": "example-replication-group"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                        "endLine": 11,
                                        "startLine": 1
                                    }
                                }
                            ]
    count(result) == 1
}