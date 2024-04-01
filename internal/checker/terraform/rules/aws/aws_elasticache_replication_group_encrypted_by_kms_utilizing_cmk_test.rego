package lib.terraform.CB_TFAWS_182
import rego.v1

test_aws_elasticache_replication_group_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticache_replication_group",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "automatic_failover_enabled": true,
                                    "availability_zones": [
                                        "us-west-2a",
                                        "us-west-2b"
                                    ],
                                    "kms_key_id": "arm:kms",
                                    "node_type": "cache.m4.large",
                                    "number_cache_clusters": "2",
                                    "parameter_group_name": "default.redis3.2",
                                    "port": "6379",
                                    "replication_group_description": "test description",
                                    "replication_group_id": "tf-rep-group-1"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_elasticache_replication_group_encrypted_by_kms_utilizing_cmk_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elasticache_replication_group",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "automatic_failover_enabled": true,
                                    "availability_zones": [
                                        "us-west-2a",
                                        "us-west-2b"
                                    ],
                                    "kms_key_id": "",
                                    "node_type": "cache.m4.large",
                                    "number_cache_clusters": "2",
                                    "parameter_group_name": "default.redis3.2",
                                    "port": "6379",
                                    "replication_group_description": "test description",
                                    "replication_group_id": "tf-rep-group-1"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 13,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}
